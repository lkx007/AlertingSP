# ex:ts=8 sw=4:
# $Id$
#
# Copyright (c) 2013 EMC Watch4net
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

use strict;
use warnings;

package Watch4net::Connectivity;
use feature "state";
use Exporter qw(import);
use Socket;
use Switch;
use Term::ANSIColor;
use Watch4net::Error qw(error_facility ok_msg);
use Watch4net::Options;
use Watch4net::Lookup qw(lookup %connection_tbl %types_tbl);

our @EXPORT_OK = qw(ip_is_valid network_chk connectivity_chk ssh_test);

# datastructure to deal with the connectivity tests for network based SPs
our %net_conn_test = (
		'ip'	=> (),
		'auth'	=> (),
		'test'	=> (),
		'extra' => (),
);

# translate from the OS number option to it's string value
sub translate_os_opt
{
	my ($opt, $thisSP) = @_;
	my ($type, $key);

	foreach (@{$types_tbl{$thisSP}}) {
		$_ =~ /(.*):(.*)/;
		$type = lc($1);
		$key= $2;
 		last if ($opt == $key); 
	}

	return $type;
}

# this function checks if an IP was already saved into the net_conn_test hash
sub already_stored
{
        my ($thisHost, $thisSP) = @_;

        foreach my $i (keys %{$net_conn_test{$thisSP}{'idx'}}) {
                foreach my $stored_val (@{$net_conn_test{$thisSP}{'idx'}{$i}{'ip'}}) {
                        return 1 if $thisHost eq $stored_val;
                }
        }
        return 0;
}

sub ip_is_valid
{
        my ($ip_addr, $thisSP) = @_;

        $ip_addr =~ s/\s+//g;
	# if $ip_addr comes as a fqdn resolve it first
	my $fqdn = gethostbyname(lc($ip_addr));
	if (defined $fqdn) {
	    $ip_addr = inet_ntoa($fqdn);
	}
        
        chomp($ip_addr);
	$ip_addr =~ s/\s+//g;

        if ($ip_addr =~ m/^(\d\d?\d?)\.(\d\d?\d?)\.(\d\d?\d?)\.(\d\d?\d?)$/) {
                if ($1 <= 255 && $2 <= 255 && $3 <= 255 && $4 <= 255) {
                        return(1);
                } else {
                        error_facility("SEVERE", "Invalid IP address: $ip_addr", $thisSP);
                        return(0);
                }
        } else {
		error_facility("SEVERE", "Invalid IP address: $ip_addr", $thisSP);
		return(0);
        }
}

#
# this function will create the config file needed by the VMAX Solutions Enabler.
# based on the user's input it will generate a netcnfg file wit the following structure
# 
# SYMAPI_SECURE  -  TCPIP  node001  WWW.XXX.YYY.ZZZ  2707  SECURE 
#
sub bootstrap_solutions_enabler
{
        my (@symname, $ip, @extra_params);
        open(my $fh, '>', @SYMAPI_CONF) or die "Could not open '@SYMAPI_CONF'!\n";

        foreach my $i (keys %{$net_conn_test{'emc-vmax'}{'idx'}}) {
                foreach my $host (@{$net_conn_test{'emc-vmax'}{'idx'}{$i}{'ip'}}) {
                        $host =~ s/\s+//g;
                        my $bulk = gethostbyname(lc($host));
                        $ip = inet_ntoa($bulk);

                        # we will use the first chunk of the host fqdn to create its SYMAPI entry.
                        # this along with the information from @xtra_params (port, secure mode) will
                        # be used to create the netcnfg file
                        @symname = split(/\./, uc($host));
                        $host = lc($symname[0]);
                        @extra_params = @{$net_conn_test{'emc-vmax'}{'idx'}{$i}{'extra'}};

                        # get rid of the key=value syntax and also make the value uppercase
                        # this will make sure we are looking the same as the netcnfg file example
                        foreach (@extra_params) {
                                s/\S+=(.*)/$1/g;
                                $_ = uc $_;
                        }
                        say $fh "$symname[0] - TCPIP $host $ip @extra_params";
                } 
        }
        close $fh;
}

#
# start of the connectivity tests
#
sub navisphere_test
{
        my ($thisHost, $username, $password, $thisSP) = @_;
        my $NAVISECCLI_CMD = "@NAVISPHERE_DIR/bin/naviseccli CUSTOM_AUTH -scope 0 -h CUSTOM_HOST getsptime 2>&1";

        # prepare for execution
        for ($NAVISECCLI_CMD) {
                s/CUSTOM_HOST/$thisHost/e;
                s/CUSTOM_AUTH/"-user $username -password $password"/e;
        }
        my $state = `$NAVISECCLI_CMD`;
	my @issues = split(/\n/,$state);

        # if there is any problem inform the user
        my $err_message;
        foreach my $line (@issues) {
        	if ($line =~  /failed/) {
        		$err_message = $line;
                	error_facility("SEVERE", "$thisHost - $err_message", $thisSP);
                	error_facility("SEVERE", "Navisphere connectivity checks for $thisHost failed!", $thisSP);
        		return(0);
        	}
        }
        if ($VERBOSE) {
                ok_msg("Detailed information for host $thisHost", "INFO");
                say $state;
                return(1);
        } 
        return(1);
}

sub solutions_enabler_test
{
        my $thisHost = shift; 
        my @SYMAPI_CONNECTION = split(/\./, uc($thisHost));

        # verify that the proper pieces of the Solutions Enabler are where they should be
        if (-e $SYMAPI_CONF[0]) {
                my $SE_CMD = "export {SYMCLI_CONNECT_TYPE=REMOTE,SYMCLI_CONNECT=$SYMAPI_CONNECTION[0]}; /opt/emc/SYMCLI/bin/symcfg list 2>&1";
                my $state = `$SE_CMD`;
	        my @issues = split(/\n/,$state);

                # if there is any problem inform the user
                my $err_message;
                foreach my $line (@issues) {
                	if ($line =~  /refused/) {
                		$err_message = $line;
                        	error_facility("SEVERE", "$thisHost - $err_message", "emc-vmax");
                        	error_facility("SEVERE", "Solutions Enabler connectivity checks for $thisHost failed!", "emc-vmax");
                		return(0);
                	}
                }
                if ($VERBOSE) {
                        ok_msg("Detailed information for host $thisHost", "INFO");
                        say $state;
                        return(1);
                }
        } else {
               say "@SYMAPI_CONF is missing! Please check your Solutions Enabler configuration.";
               return(0);
        }
        return(1);
}

# snmp tests require the use of net-snmp tools
sub snmp_test
{
	my ($thisHost, $version, $password, $thisSP, $type) = @_;
	my ($key, $err_message);
	my $SNMP_CMD = 'snmpget -Cf -CUSTOM_VERSION -c CUSTOM_COMMUNITY_STRING CUSTOM_HOST sysName.0 2>&1';

	# prepare the command for execution
	for ($SNMP_CMD) {
		s/CUSTOM_VERSION/$version/e;
		s/CUSTOM_COMMUNITY_STRING/$password/e;
		s/CUSTOM_HOST/$thisHost/e;
	}

	my $state = `$SNMP_CMD`;
	my @issues = split(/\n/,$state);

        if ($VERBOSE) {
                ok_msg("Detailed information for host $thisHost", "INFO");
                say $state;
                return(1);
        }

	# if there is any problem inform the user
	foreach my $line (@issues) {
		if ($line =~  /Timeout/) {
			$line =~ /:(.*)/;
			$err_message = $1;
                	error_facility("SEVERE", "$thisHost - $err_message", $thisSP . "-" . $type);
                	error_facility("SEVERE", "SNMP connectivity checks for $thisHost failed!", $thisSP . "-". $type);
			return(0);
		}
	}
		
	if (!grep(/SEVERE/, $state)) {
		return(1);
	} else {
                error_facility("SEVERE", "SNMP connection failed!", $thisSP);
		return(0);
	}
}

# SOAP request only work under HTTP for now.
# TODO: HTTPS
sub soap_test
{
	my ($thisHost, $username, $password, $thisSP) = @_;
	my $SOAP_CMD = 'curl -fs -X POST -H "CIM Method: EnumerateInstances" -H "CIMOperation: MethodCall" -H "CIMProtocolVersion: 1.0" -H "Content-Type: text/xml" -H "CIMObject: CUSTOM_NS"  -d @extra/CUSTOM_REQUEST -u CUSTOM_AUTH  http://CUSTOM_HOST/CUSTOM_URL_TRAIL/';

	# change the SOAP request parameters based on the vendor
	my ($thisNameSpace, $thisSOAPrequest, $thisURLtrail);
	switch($thisSP) {
	case /hitachi/ { 
		$thisNameSpace = "root/smis/current";
		$thisSOAPrequest = "HITACHI_FCPort.request"; 
		$thisURLtrail = "DeviceManager";
	}
	}

	# prepare the command for execution
	for ($SOAP_CMD) {
		s/CUSTOM_HOST/$thisHost/e;
		s/CUSTOM_NS/$thisNameSpace/e;
		s/CUSTOM_REQUEST/$thisSOAPrequest/e;
		s/CUSTOM_AUTH/"$username:$password"/e;
		s/CUSTOM_URL_TRAIL/$thisURLtrail/e;
	}

	my $state = `$SOAP_CMD`;
	if (grep(/xml\s+version=/, $state)) {
		return(1);
	} else {
                error_facility("SEVERE", "SOAP connection failed!", $thisSP);
		return(0);
	}
}

# WWW test via GET
sub www_test
{
	my ($thisHost, $username, $password, $thisSP) = @_;
	my $WWW_CMD = 'curl -k -f -s "https://CUSTOM_HOST/CUSTOM_URL_TRAIL" -u CUSTOM_AUTH'; 

	# change the Web Service request parameters based on the vendor
	my ($thisNameSpace, $thisURLtrail);
	switch($thisSP) {
	case /vmware-vcenter/ { 
		$thisURLtrail = "mob/?moid=ServiceInstance&doPath=content%2eabout";
	}
	}

	# prepare the command for execution
	for ($WWW_CMD) {
		s/CUSTOM_HOST/$thisHost/e;
		s/CUSTOM_AUTH/"$username:$password"/e;
		s/CUSTOM_URL_TRAIL/$thisURLtrail/e;
	}

	my $state = `$WWW_CMD`;

	if (grep(/fullName/, $state)) {
		$state =~ /fullName>(.*)<\/fullName/;
		my $ret_val = "$thisHost is running $1";
		ok_msg($ret_val, "INFO");
		return(1);
	} else {
                error_facility("SEVERE", "WebServices connection failed!", $thisSP);
		return(0);
	}
}

# Generic-RSC test case
sub rsc_test
{
	my ($thisHost, $thisOS, $thisSP) = @_;
	my ($type, $key, $err_message);
	my $RSC_CMD = "cd @REMOTE_RSC_DIR && bin/ondemand-script-execution.sh -h CUSTOM_HOST -w CUSTOM_URL -s scripts/CUSTOM_OS/LunMappingDetection.pl 2>&1";

	for ($RSC_CMD) {
		s/CUSTOM_OS/$thisOS/e;
		s/CUSTOM_HOST/$thisHost/e;
		# XXX for some reason the ondemand.conf file contains the wrong webservice.url
		s!CUSTOM_URL!"https://localhost:48443/Collecting/Collector-Manager/Generic-RSC/Lun-mapping-detection?wsd"!e;
	}

	my $state = `$RSC_CMD`;
	my @issues = split(/\n/,$state);

	# if Generic-RSC reports any errors we need to inform the user
	foreach my $line (@issues) {
		if ($line =~  /Exception|failed|Could\s+not/) {
			$line =~ /:(.*)/;
			$err_message = $1;
                	error_facility("SEVERE", "$thisHost - $err_message", $thisSP);
                	error_facility("SEVERE", "Generic-RSC connectivity checks for $thisHost failed!", $thisSP);
			return(0);
		}
	}
		
	if (!grep(/SEVERE/, $state)) {
		return(1);
	} else {
                error_facility("SEVERE", "Generic-RSC connection failed!", $thisSP);
		return(0);
	}
}

sub ssh_test
{
	my ($host, $username, $password, $thisSP) = @_;
	my $SSH_CMD = "cd @APG_POC_DIR/extra && @JAVA_BIN -cp .:trilead-ssh2-w4n-r856.jar ssh2test";

	my $state = "$SSH_CMD $host $username $password 2>/dev/null";
	chomp ($state);	

        if ($VERBOSE) {
                say $state;
        }

	if ($state) {
		# ssh works!
		return(1);
	} else {
                error_facility("SEVERE", "SSH connection failed!", $thisSP);
		return(0);
	}
}

# checks if the host has IP connectivity.
# returns 1 if yes and 0 if no.
sub network_chk
{
        my ($thisHost, $thisSP) = @_;
        my $alive;

        if (ip_is_valid($thisHost, $thisSP)) {
                $alive = `ping -c 1 -n -W 1 $thisHost | egrep "64 bytes"`;
                if ($alive) {
                        # no problem. it's up!
                        return(1);
                } else {
                        error_facility("SEVERE", "Host $thisHost seems down!", $thisSP);
                        return(0);
                }
        }
}

sub connectivity_chk
{
        my $thisSP;
        if (defined(@_)) {
                $thisSP = $_[0];
        }

        if (!defined(my $check = lookup($thisSP, "name"))) {
                print "Error. Cannot find this Solution Pack ($thisSP). Did you misspell it?\n";
                exit(0);
        }

        # which connectivity tests must be done for this SP?
        printf "\nDoing connectivity tests for %s\n", $thisSP;

	our $record;
        my $key = lookup($thisSP, "connection");
        my ($type, $host_down, $someone_is_alive);
        state ($username, $password, $thisHost);

	# this first loop will populate our datastructure while the second one
	# will execute the connectivity checks
        foreach (@{$connection_tbl{$thisSP}}) {
                $_ =~ /(.*):(.*)/;
                $type = $1;
                $key = $2;

                open(my $thisFH, '<', "conf/$thisSP.answers");

                while (<$thisFH>) {
			chomp;
			# get the record number from the input file but drop the 
			# line containing *want* as this might lead to a mistake
			if ($_ =~ m/.*\[(\d+)\].*/ && !(grep(/want/, $_))) {
				$record = $1;
			}

                        switch ($type) {
                        case /^network-ip$/ {
                                if (/$key/) {
                                        $thisHost = $1;
                                        $thisHost =~ s/\s+//g;
                                
                                        # only store new ip addresses
					if (already_stored($thisHost, $thisSP)) {
                                                last;
                                        }

                                        my $message ="Checking if the host is reachable: $thisHost";
					# if network_chk is 1 it means that the host is alive!
                                        if ($someone_is_alive = network_chk($thisHost, $thisSP)) {
                                                # this means that if there is any 
                                                # host alive we will try to connect
                                                # to it with the credentials
                                                if ($someone_is_alive) {
                                                        $host_down = 0;
							push(@{$net_conn_test{$thisSP}{'idx'}{$record}{'ip'}}, 
							$thisHost);
							ok_msg($message, "OK");
                                                } else {
                                                        $host_down = 1;
							$someone_is_alive = 0;
                                                }
                                        } else {
                                                $host_down = 0;
                                                $someone_is_alive = 1;
                                        }
                                }
                        }
			case /^network-port$/ {
				if (/$key/) {
					my $thisPort = $1;
					# pop the host information from the stack and then append it to the port
					my $thisHost = pop(@{$net_conn_test{$thisSP}{'idx'}{$record}{'ip'}});
					push(@{$net_conn_test{$thisSP}{'idx'}{$record}{'ip'}}, "$thisHost:$thisPort");
				}
			}
                        case /^network-auth-user$/ {
                                if (/$key/ && !$host_down) {
                                        $username = $1;
					push(@{$net_conn_test{$thisSP}{'idx'}{$record}{'auth'}}, 
						$username);
                                }
                        }
                        case /^network-auth-passwd$/ {
                                if (/$key/ && !$host_down) {
                                        $password = $1;
					push(@{$net_conn_test{$thisSP}{'idx'}{$record}{'auth'}},
						$password);
                                }
                        }
                        case /^network-extra$/ {
                                if (/$key/) {
                                        my $opt = $1;
                                        my $ret_val;

                                        switch ($thisSP) {
                                        case /emc-vmax/ {
                                                $ret_val = $opt;
                                        }
                                        case /generic-rsc/ {
					        $ret_val = translate_os_opt($opt, $thisSP);
                                        }
                                        case /snmp/ {
                                                $ret_val = $opt;
                                        }
                                        }
					push(@{$net_conn_test{$thisSP}{'idx'}{$record}{'extra'}},
						$ret_val);
                                }
                        }
                        case /^network-os$/ {
                                if (/$key/) {
                                        my $opt = $1;
                                        my $ret_val;

                                        switch ($thisSP) {
                                        case /generic-rsc/ {
					        $ret_val = translate_os_opt($opt, $thisSP);
                                        }
                                        }
					push(@{$net_conn_test{$thisSP}{'idx'}{$record}{'extra'}},
						$ret_val);
                                }
                        }
			# $key contains what type of network test we need to use with this SP. e.g: ssh, SOAP,...
			case /^network-protocol$/ {
				if ($key) {
					my $unique = grep(/$key/, 
						@{$net_conn_test{$thisSP}{'idx'}{$record}{'test'}});
				if (!$unique) {
					# only push to the array if not unique
					push(@{$net_conn_test{$thisSP}{'idx'}{$record}{'test'}}, $key);
				}
				}
			}
                        }
                }
        }

        # do some pre-testing activities such as generating the Solution's Enabler netcnfg file
        if ($thisSP eq "emc-vmax") {
                bootstrap_solutions_enabler();
        }

        foreach my $i (keys %{$net_conn_test{$thisSP}{'idx'}}) {
        	foreach (@{$net_conn_test{$thisSP}{'idx'}{$i}{'test'}}) {
			switch ($_) {
                        case /navisphere/ {
                        	foreach my $host (@{$net_conn_test{$thisSP}{'idx'}{$i}{'ip'}}) {
        				($username, $password) = @{$net_conn_test{$thisSP}{'idx'}{$i}{'auth'}};
                        		my $message = "Checking Navisphere commands for $host";
                                                                                                         
                        		if (navisphere_test($host, $username, $password, $thisSP)) {
                        			ok_msg($message, "OK");
                        		}
                        	}
                        }
			case /rsc/ {
				foreach my $host (@{$net_conn_test{$thisSP}{'idx'}{$i}{'ip'}}) {
					my @os = @{$net_conn_test{$thisSP}{'idx'}{$i}{'extra'}};	
					my $message = "Checking Generic-RSC commands for $host";

					if (rsc_test($host, $os[0], $thisSP)) {
						ok_msg($message, "OK");
					}
				}
			}
			case /ssh/ {
        			foreach my $host (@{$net_conn_test{$thisSP}{'idx'}{$i}{'ip'}}) {
					($username, $password) = @{$net_conn_test{$thisSP}{'idx'}{$i}{'auth'}};
					my $message = "Checking SSHv2 authentication for $host";
					if (ssh_test($host, $username, $password, $thisSP)) {
						ok_msg($message, "OK");
					}
				}
			} 
                        case /solutions_enabler/ {
        			foreach my $host (@{$net_conn_test{$thisSP}{'idx'}{$i}{'ip'}}) {
					my $message = "Checking Solutions Enabler commands for $host";
                                        say "\nWaiting for a reply from $thisHost";

                                        if(solutions_enabler_test($host)) {
                                                ok_msg($message, "OK");
                                        }
                                }
                        }
			case /soap/ {
        			foreach my $host (@{$net_conn_test{$thisSP}{'idx'}{$i}{'ip'}}) {
					($username, $password) = @{$net_conn_test{$thisSP}{'idx'}{$i}{'auth'}};
					my $message = "Checking SOAP authentication for $host";
					if (soap_test($host, $username, $password, $thisSP)) {
						ok_msg($message, "OK");
					}
				}
			}
                        case /snmp/ {
				foreach my $host (@{$net_conn_test{$thisSP}{'idx'}{$i}{'ip'}}) { 
        				$password = @{$net_conn_test{$thisSP}{'idx'}{$i}{'auth'}}[0];
					my $version = @{$net_conn_test{$thisSP}{'idx'}{$i}{'extra'}}[0];
                                        my $type = @{$net_conn_test{$thisSP}{'idx'}{$i}{'extra'}}[1];

        				my $message = "Checking SNMP authentication for $host";
        				if (snmp_test($host, $version, $password, $type, $thisSP)) {
        					ok_msg($message, "OK");
        				}
        			}
                        }
			case /www/ {
				foreach my $host (@{$net_conn_test{$thisSP}{'idx'}{$i}{'ip'}}) { 
        				($username, $password) = @{$net_conn_test{$thisSP}{'idx'}{$i}{'auth'}};
        				my $message = "Checking Web Services authentication for $host";
        				if (www_test($host, $username, $password, $thisSP)) {
        					ok_msg($message, "OK");
        				}
        			}
			}
			}
		}
	}

	# no one is alive so inform the upgrade routine
	if (!$someone_is_alive) {
	        return(1);
	}

}
return(1);
