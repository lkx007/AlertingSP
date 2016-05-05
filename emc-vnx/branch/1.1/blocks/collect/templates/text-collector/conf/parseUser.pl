#!/usr/bin/perl

# parseUser.pl cifs|nfs
#
# parse server_stats -monitor cifs.client | nfs.client output
# 	/nas/bin/server_stats <dm> -monitor nfs.client -format text -interval 3600 -count 1 -terminationsummary no -type diff
# require one unique time bucket in the output (if not, will aggregate anyway using the last timestamp)

use Time::Local;

# CIFS:
# server_2                  IP address                      CIFS         CIFS     CIFS     CIFS       CIFS      CIFS     CIFS     CIFS       CIFS     CIFS Server Name    CIFS User Name  
# Timestamp                                                Client         Total      Read Ops     Write     Suspicious    Total      Read KiB     Write        Avg
#                                                          Name         Ops diff      diff      Ops diff      Ops       KiB diff      diff      KiB diff   uSecs/call
# 14:57:40   10.128.9.100_16294    10.128.9.100            469           0         469           1       30000           0       30000      379642  VNXTEST            VNXTEST\administrator

# NOW:
# 13:10:55   HOP\cifstest                     2        2        0           0       64       64        0           8

# NFS:
# server_2                    Client                      NFS       NFS Read      NFS         NFS         NFS       NFS Read      NFS         NFS  
# Timestamp                                              Total        Ops        Write     Suspicious    Total        KiB        Write        Avg  
#                                                       Ops diff      diff      Ops diff    Ops diff    KiB diff      diff      KiB diff   uSec/call
# 15:57:10   id=172.23.137.149                                  3           0           0           0           0           0           0          5

my $topN = 5;
my $pollingPeriod = 3600; # secs

my $protocol = $ARGV[0];
if ( $protocol =~ /cifs/i ) {
	$protocol = "cifs";
} else {
	$protocol = "nfs";
}

# to find the right date
my $now = time();
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime( $now );

my $timestamp;
my ($time, $ipPort, $ip, $totalOps, $readOps, $writeOps, $suspectOps, $totalBytes, $readBytes, $writeBytes, $avgTime, $server, $user);
my $key;
my %aggregate;

while(<STDIN>) {
	next if /^$/;
        chomp;

	if ( $protocol eq "cifs" ) {
		# next if ! (/^[\d:]+\s+(id=)?[\d\.\_]+\s+([\w\d\.]+)\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+(\w+\s+[\w\\]+\s*)$/);
		next if ! (/^[\d:]+\s+[\w\\]+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s*$/);
        	$_ =~ s/[\ ]+/;/g;
	        ($time, $user, $totalOps, $readOps, $writeOps, $suspectOps, $totalBytes, $readBytes, $writeBytes, $avgTime) = split(';');
		# $ip =~ s/id=//;
		$ip = "";
		$server = "";
		$key = $ip . $user . $server;
	} else {
		next if ! (/^[\d:]+\s+(id=)?[\d\.\_]+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s+\d+\s*$/);
        	$_ =~ s/[\ ]+/;/g;
	        ($time, $ip, $totalOps, $readOps, $writeOps, $suspectOps, $totalBytes, $readBytes, $writeBytes, $avgTime) = split(';');
		$ip =~ s/id=//;
		$server = "";
		$user = "";
		$key = $ip;
	}

	if ( $time ne "" ) {
		# date in file > now => yesterday's stats
		my ($fhour, $fmin, $fsec) = split(':', $time);
		my $fts = timelocal($fsec, $fmin, $fhour, $mday, $mon, $year) - $pollingPeriod;
		if ( $fts > $now ) {
			$timestamp = $fts - ( 24 * 60 * 60 );
		} else {
			$timestamp = $fts;
		}
	}

        if ( defined $aggregate{$key}  ) {
                $aggregate{$key}{TotalOps} += $totalOps;
                $aggregate{$key}{ReadOps} += $readOps;
                $aggregate{$key}{WriteOps} += $writeOps;
                $aggregate{$key}{SuspectOps} += $suspectOps;
                $aggregate{$key}{TotalBytes} += $totalBytes;
                $aggregate{$key}{ReadBytes} += $readBytes;
                $aggregate{$key}{WriteBytes} += $writeBytes;
		$aggregate{$key}{AvgTime} += $avgTime * $totalOps; # weighted
        } else {
                $aggregate{$key}{IP} = $ip;
                $aggregate{$key}{User} = $user;
                $aggregate{$key}{Server} = $server;
                $aggregate{$key}{TotalOps} = $totalOps;
                $aggregate{$key}{ReadOps} = $readOps;
                $aggregate{$key}{WriteOps} = $writeOps;
                $aggregate{$key}{SuspectOps} = $suspectOps;
                $aggregate{$key}{TotalBytes} = $totalBytes;
                $aggregate{$key}{ReadBytes} = $readBytes;
                $aggregate{$key}{WriteBytes} = $writeBytes;
		$aggregate{$key}{AvgTime} = $avgTime * $totalOps; # weighted
        }
}

print "Time;IP;User;Server;TotalOps;ReadOps;WriteOps;SuspectOps;TotalBytes;ReadBytes;WriteBytes;AvgTime\n";
my %output;
my $line;
foreach my $top ( "WriteOps", "ReadOps" ) {

	my @keysSortedByTopN = sort {$aggregate{$b}{$top} <=> $aggregate{$a}{$top}} keys %aggregate;
	my $min = ($topN,scalar @keysSortedByTopN)[$topN > @keysSortedByTopN]; # min from FCO

	# dedup lines if one entry is part of multiple TopN
	foreach my $k ( @keysSortedByTopN[ 0 .. $min -1 ] ) {
		$line = $timestamp . ";" .
			$aggregate{$k}{IP} . ";" .
			$aggregate{$k}{User} . ";" .
			$aggregate{$k}{Server} . ";" .
			$aggregate{$k}{TotalOps} . ";" .
			$aggregate{$k}{ReadOps} . ";" .
			$aggregate{$k}{WriteOps} . ";" .
			$aggregate{$k}{SuspectOps} . ";" .
			$aggregate{$k}{TotalBytes} . ";" .
			$aggregate{$k}{ReadBytes} . ";" .
			$aggregate{$k}{WriteBytes} . ";" .
			( $aggregate{$k}{TotalOps} > 0 ? ( $aggregate{$k}{AvgTime} / $aggregate{$k}{TotalOps} ) : 0 );
		$output{ $line } = 1;
	}

}

foreach my $k ( keys %output ) {
	print $k . "\n";
}

