#!/usr/bin/perl
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

use v5.10;
use Getopt::Long;
use Switch;
use feature "state";
use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(abs_path $0) . '/lib';

use Watch4net::Connectivity qw(ip_is_valid network_chk connectivity_chk ssh_test);
use Watch4net::Error qw(error_facility p_debug);
use Watch4net::Lookup qw(lookup %block_tbl %connection_tbl %types_tbl);
use Watch4net::Options;
use Watch4net::Packages qw(is_installed do_install has_answers list_sp remove_sp);
 
our ($sp_filenames, @sp_installed, @unique, %cache, %global_ref);

sub usage
{
	print "usage: poc-enabler [-C [solution_pack]] [-lru] [-f file] [-sp solution_pack]\n";
	exit(0);
}

# a signal handling facility
sub sig_handler
{
        unlink @LOCKFILE;
}

$SIG{INT}  = \&sig_handler;
$SIG{HUP}  = \&sig_handler;
$SIG{QUIT} = \&sig_handler;
$SIG{SEGV} = \&sig_handler;
$SIG{TERM} = \&sig_handler;

# before we run anything, we need to know if the user meets our requirements
sub background_check
{
        my $clear = 1;

        my $JAVA = `which java 2>&1`;
        unless (-e $JAVA_BIN[0] || -e $JAVA) {
                say "Cannot find java!";
                $clear = 0;
        }

        my $NAVISECCLI = `which naviseccli 2>&1`;
        unless (-e "$NAVISPHERE_DIR[0]/bin/naviseccli") {
                say "Cannot find naviseccli under @NAVISPHERE_DIR. Please verify your Navisphere install!";
                $clear = 0;
        }

        unless (-e $REMOTE_RSC_DIR[0]) {
                say "Missing Generic-RSC! Please verify your install!";
                $clear = 0;
        }

        my $NET_SNMP_BIN = `which snmpget 2>&1`;
        chomp $NET_SNMP_BIN;
        unless (-e $NET_SNMP_BIN) {
                say "Missing snmpget! Please verify your net-snmp tools install!";
                $clear = 0;
        }

        return($clear);
}

sub open_file
{
	my ($filename, $opt_f_arg);
	$opt_f_arg = shift;

	$filename = $opt_f_arg or die "Missing input file\n";
	open(my $fh, '<', $filename) or die "Could not open '$filename' $!\n";
	return $fh, $filename;
}

sub row_lookup
{
	my ($key, $value);
	$key = shift;
	$value = (!$cache{$key}) ? 0 : $cache{$key};
	return $value
}

# count the total number of rows in each answers file and update the global_ref table
sub total_nb_rows
{
	my $opt_f_arg = shift;
        my ($fh, $filename) = open_file($opt_f_arg);
	my ($thisFile, $thisFH, $thisSP, $thisSP_Collector, $lastSP, $rowNum, $want);

	while (my $line = <$fh>) {
		chomp $line;
		foreach (@::unique) {
			if ($line =~ /$_/) {
				my @regex = split(/,/, lc($_));

				$thisSP = $regex[0];
				$global_ref{$thisSP}++;
			}
		}
	}
	close(thisFH);
}

# thou shall create and populate the answer files
sub genesis
{
	my $FILE = shift;
	create_answer_files($FILE);
	populate($FILE);
	
	return(0);
}

sub create_answer_files
{
	my $opt_f_arg = shift;
	my ($fh, $filename) = open_file($opt_f_arg);
	my ($thisFile, $thisFH);

	# only create answer files if they do not exist
	my $ret = `ls @APG_POC_DIR/conf | egrep answers`;
	if (!$ret) {
		while (my $line = <$fh>) {
			chomp $line;
			
			my @fields = split(/,/, $line);
			push @::sp_filenames, $fields[0];
		}
		
		@::unique  = do { 
				my %seen; 
				grep { !$seen{$_}++ } @::sp_filenames
				};

		foreach (@::unique) {
			$thisFile = "conf/" . $_ . ".answers";
			$thisFH = "fh_" . lc($_);
			print "Creating file " . lc($_) . ".answers\n";

			unless(open thisFH, '>', lc($thisFile)) {
				die "\nUnable to create file: " . $thisFile;
			}
			close thisFH;
		}
	}
}

# fix lexical issues with the Generic-RSC
sub fix_my_name
{
	my $target = "generic-rsc";
	open(thisFH, "+< conf/$target" . ".answers") or die "\nCannot open the file: $_\n";
	my ($out, $type, $key, $my_value);

	while (<thisFH>) {
		# get the value from the file and change it
		$_ =~ s/questions(.*)(\.generic-rsc\..*)/questions.Generic-RSC$2/;
		$_ =~ s/generic-rsc(.*)action/generic-rsc\.Generic-RSC\.action/;
		$_ =~ s/\.\./\./g;
		$out .= $_;
	}
	seek(thisFH, 0, 0);
	print thisFH $out;
	truncate(thisFH, tell(thisFH));
	close(thisFH);
}

# fix SolutionPack expectations for everyone defined in the %types_tbl hash
sub fix_expectations
{
	foreach my $target (keys %types_tbl) {
		open(thisFH, "+< conf/$target" . ".answers") or die "\nCannot open the file: $_\n";
		my ($out, $type, $key, $my_value, $my_query);

		while (<thisFH>) {
			# get the value from the file
			$my_value = $_;
                        
                        if ($target eq "generic-rsc") {
                                $my_query = "os";
                         } elsif ($target eq "netapp-filer") {
                                $my_query = "type";
                         }

                        $my_value =~ s/$my_query=(.*)/$1/;
                        chomp($my_value);
                        
                        # translate the string value to it's number counterpart, e.g: 
                        # Linux to 3.
                        foreach (@{$types_tbl{$target}}) {
                        	$_ =~ /(.*):(.*)/;
                        	$type = $1;
                        	$key= $2;
                        	last if (uc($my_value) eq $type); 
                        }
                        
                        $_ =~ s/$my_query=(.*)/$my_query=$key/g;
                        $out .= $_;
		}
		seek(thisFH, 0, 0);
		print thisFH $out;
		truncate(thisFH, tell(thisFH));
		close(thisFH);
	}
}

sub fix_caveat
{
	my $thisSP = shift;
	open(my $thisFH, '>>', "conf/$thisSP.answers") or die "\nCannot open the file: $_\n";
	select $thisFH;

	switch ($thisSP) {
	case "oracle-database" {
				say "questions.oracle-database.oracle-database-collect.use_enrichment=1";
				say "questions.oracle-database.oracle-database-collect.use_advancedsettings=1";
	}
	case "emc-vmax" 	{
				say "questions.emc-vmax.emc-vmax-collect.emcvmax.want=0";
				say "questions.emc-vmax.emc-vmax-collect.emcvmax.perf.pollingperiod=7200";
				say "questions.emc-vmax.emc-vmax-collect.symapi.path.want=1";
				say "questions.emc-vmax.emc-vmax-collect.symapi.connect_type=1";
				say "questions.emc-vmax.emc-vmax-collect.symapi.connect=symname";
	}
	# for both file and block
	case /emc-vnx/		{
				say "questions.$thisSP.emc-vnx-collect.events.host=localhost";	
				say "questions.$thisSP.emc-vnx-collect.events.port=52001";
				say "questions.$thisSP.emc-vnx-collect.naviseccli.path.want=1";
	}
	case /generic-rsc/	{
				say "questions.Generic-RSC.generic-rsc.genericrsc.push_inq=1";
				say "questions.Generic-RSC.generic-rsc.genericrsc.host[0].want=0";

	}
	case /hitachi-device-manager/ {
				say "questions.hitachi-device-manager.hitachi-device-manager-collect.hds.use_advancedsettings=1";

	}
	case /vmware/		{
				say "questions.vmware-vcenter.vmware-vcenter-collect.use_advancedsettings=1";
	}
	}
	select STDOUT;
}

# populate the files with the answers
sub populate
{
	# re-open the file and populate it
	my $opt_f_arg = shift;
        my ($fh, $filename) = open_file($opt_f_arg);
	my ($thisFile, $thisFH, $thisSP, $thisSP_Collector, $lastSP, $rowNum, $want);

	# get the total number of rows
	total_nb_rows($opt_f_arg);

	$rowNum = 0;
	$want = 0;
	while (my $line = <$fh>) {
		chomp $line;
		foreach (@::unique) {
			if ($line =~ /$_/) {
				my $has_rows;
				my @regex = split(/,/, lc($_));

				if (!$thisSP) {
					$lastSP = "";
				} else {
					$lastSP = $thisSP;
				}
				
				$thisFile = "conf/" . $regex[0] . ".answers";
				$thisFH = "fh_" . $regex[0];
				$thisSP = $regex[0];

				open(thisFH, '>>', $thisFile) or die "\nCannot write to file: " . $thisFile;

				if ($line =~ /rowNum/) {
					$has_rows = 1;
				}

				$line =~ s/^/#/g;
				$line =~ s/,/\n/g;
				$line =~ s/\s*$//g;

				$rowNum = row_lookup($thisSP);
				$thisSP_Collector = lookup($thisSP, "collector");
				
				if (!defined($thisSP_Collector)) {
					last;
				}

				# pre-generate some of the questions reguarding the 
				# failover and alert db
				if ($rowNum < 1) {
					say thisFH "dependencies.$thisSP_Collector.$thisSP.action.0=yes";
					say thisFH "questions.$thisSP.$thisSP_Collector.storage.failover=0";
					say thisFH "questions.$thisSP.$thisSP_Collector.storage.timeseries.socketconnector.host=localhost";
					say thisFH "questions.$thisSP.$thisSP_Collector.storage.timeseries.socketconnector.port=2020";
					say thisFH "questions.$thisSP.$thisSP_Collector.use_alert=0";
					say thisFH "questions.$thisSP.$thisSP_Collector.alert.timeseries.socketconnector.host=localhost";
					say thisFH "questions.$thisSP.$thisSP_Collector.alert.timeseries.socketconnector.port=2010";

					# caveats required by certain SPs
					fix_caveat($thisSP);
				}

				if ($has_rows)	{
					if ($line =~ /rowNum/) {
						$line =~ s/rowNum/$rowNum/g;
						print thisFH $line;
					}
					
					if ($thisSP eq "hitachi-device-manager") {
						say thisFH "\nquestions.$thisSP.$thisSP_Collector.hds.devicemanager[$rowNum].port.want=0";
						say thisFH "questions.$thisSP.$thisSP_Collector.hds.devicemanager[$rowNum].usesecure=0";
					}
					if ($thisSP eq "emc-vnx-file") {
						say thisFH "questions.$thisSP.$thisSP_Collector.vnx[$rowNum].type=1";
				                say thisFH "questions.$thisSP.$thisSP_Collector.vnx[$rowNum].block.use_secfile=1";
                                                say thisFH "questions.$thisSP.$thisSP_Collector.vnx[$rowNum].block.userscope=1";
                                        }
                                        if ($thisSP eq "emc-vnx-block") {
						say thisFH "questions.$thisSP.$thisSP_Collector.vnx[$rowNum].type=0";
				                say thisFH "questions.$thisSP.$thisSP_Collector.vnx[$rowNum].block.use_secfile=1";
                                                say thisFH "questions.$thisSP.$thisSP_Collector.vnx[$rowNum].block.userscope=1";

                                        }

					# save this SP name into the lookup table
					my $previousRow = $rowNum;
					my $rowName;
					$rowName = lookup($thisSP, "name");

					# if this is the last row we turn the want variable off
					if ($rowNum == ($global_ref{$thisSP} - 1)) {
						$want = 1;
					} else {
						$want = 0;
					}
					# update the rowNum counter for the want properties. Reason being that the next
					# line always needs to be indexed with $rowNum + 1
					$rowNum++;
					say thisFH "\nquestions.$thisSP.$thisSP_Collector.$rowName\[$rowNum].want=$want";

					# these are very particular cases. they will stay here for now	
					if ($thisSP eq "emc-vmax") {
						say thisFH "questions.$thisSP.$thisSP_Collector.vmax[$rowNum].want=$want";
					} elsif ($thisSP eq "hitachi-device-manager") {
						say thisFH "questions.$thisSP.$thisSP_Collector.hds.devicemanager[$rowNum].usesecure=0";
                                        }
				}
				$cache{$thisSP}++;

				close(thisFH);
				}
			}
		}
	# various fixes to align the answers files to manage-modules.sh expectations
	fix_my_name();
	fix_expectations();
}

sub pre_upgrade
{
	my (@targets, $target_name);
	@targets = `ls -1 @APG_POC_DIR/conf/ | egrep answers`;

	if (@targets) {	
		foreach(@targets) {
			$target_name = $_;
			$target_name =~ s/.answers//g;
			dispatch($_);
		}
	} else {
		print "No answer files were found!\n";
		genesis(@CONFFILE);
		pre_upgrade();
	}
}

sub do_upgrade
{
	my ($target, $target_name, $target_collector);
	$target = shift;
	$target_name = shift;

	if ($::FORCE_INSTALL_CHECK) {
		# check if the SP is installed
		my $ret = is_installed($target, $target_name);

		if (!$ret) {
			do_install($target, $target_name);
		} elsif ($ret == 2) {
			return(0);
		}
	}

	#print "Upgrading " . $target_name . " with answers from " . "$target\n";

	$target_collector = lookup($target_name, "collector");

	if ($target_collector eq "NOP"){
		say "Nothing to be done for $target_name";
		return(0);
	}
	# this needs to be changed 
	if ($target_name eq "generic-rsc") {
		$target_collector = '';
	}
	print "Upgrading " . $target_name . " with answers from " . "$target\n";
	system("@APG_BIN/manage-modules.sh update $target_collector $target_name --load=@APG_POC_DIR/conf/$target");
}

# This is the main routine that will go ahead and upgrade the selected solution packs 
# with the provided answers. It will in turn call the install subroutines if the 
# SolutionPack needs to be first installed.
our $a_flag = 0;
sub dispatch
{
	my $target = shift;
	my ($answer, $target_name);
	
	for (;;) {
		$target_name = $_;
		$target_name =~ s/.answers//g;
		chomp $target_name;
		
		if ($a_flag < 1) {
			# check if the SolutionPack is installed
			my $ret = is_installed($target, $target_name);
			if ($ret == 0) {
				do_install($target, $target_name);
				last;
			# if it's not installed we can't upgrade it ;)
			} #else { last; };

			print "Ready to upgrade " . $target_name . "? [y/n/all/quit]: ";
		
			$answer = <STDIN>;
			chomp $answer;

			if ($answer eq "all") {
				$a_flag = 1;
			} if ($answer eq "n") {
				last;
			} if ($answer eq "y") {
				do_upgrade($target, $target_name);
				last;
			} if ($answer eq "quit") {
				exit(0);
			}
		# do not bother asking if the user is ready to upgrade as the 
		# a_flag denotes 'all' SolutioPacks will be upgraded
		} elsif ($a_flag > 0) {
			my $ret = is_installed($target, $target_name);
			if ($ret == 0) {
				do_install($target, $target_name);
				last;
			}; 
			do_upgrade($target, $target_name);
			last;
		}
	}
}

# command line options
our ($opt_c, $opt_i, $opt_f, $opt_l, $opt_r, $opt_u, $opt_v, $c_flag, $f_flag, $u_flag, @solutionpacks);

if (@ARGV <= 0) {
	usage();
	exit(0);
}

GetOptions('C=s' 		=> \$opt_c, 		# connectivity check
	   'f=s' 		=> \$opt_f, 		# filename
	   'i' 			=> \$opt_i, 		# force install check
	   'l'			=> \$opt_l,		# list installed SolutionPacks
	   'r=s' 		=> \$opt_r, 		# remove Solution Pack
   	   'u'	 		=> \$opt_u, 		# update
           'v'                  => \$opt_v,             # set verbose mode
	   "sp|solutionpack=s@" => \@solutionpacks);	# individual SolutionPack

if ($opt_c) {$c_flag = 1;}
if ($opt_f) {$f_flag = 1;}
if ($opt_i) {$FORCE_INSTALL_CHECK = 1};
if ($opt_u) {$u_flag = 1;} 
if ($opt_v) {$VERBOSE = 1};

# remove a Solution Pack
if (defined $opt_r) {
	remove_sp($opt_r);
}

# list installed SolutionPacks
if (defined $opt_l) {
	list_sp(); 
}

# do connectivity checks only
if ($c_flag) {
	if ($opt_c =~ /all/) {
		foreach my $thisSP (keys %connection_tbl) {
			# check if the answer file exist
			if (!has_answers($thisSP)) {
				genesis(@CONFFILE);
			} elsif (connectivity_chk($thisSP)) {
					print "Connectivity tests for " . $thisSP . " finalized with success.\n";
			}
		}
	} else {
                if (lookup($opt_c, "name")) {
		        if (!has_answers($opt_c)) {
		        	genesis(@CONFFILE);
		        } elsif(connectivity_chk($opt_c)) {
		        		print "Connectivity tests for " . $opt_c . " finalized with success.\n";
		        }
                }
	}
exit(0);
}

# go over each solutionpack specified by the -sp flag
if (@solutionpacks) {
	`rm -rf .installed_targets`;
	my $sp_name; 
	my $sp_file;
	foreach (@solutionpacks) {
		$sp_name = $_;
		$sp_file = $_ . ".answers";
		if (!has_answers($sp_name)) {
			genesis(@CONFFILE);
		}
		if (connectivity_chk($sp_name)) {
			my $answer;
			for(;;) {
				print "One or more host is down. Proceed with the upgrade? [y/n]: ";
				$answer = <STDIN>;
				chomp($answer);
				if ($answer eq "n") {
					exit(0);
				} else {
					last;
				} 
			}
		}
		do_upgrade($sp_file, $sp_name);
	}
	exit(0);
# upgrade and use a custom file as input
} if ($u_flag && $f_flag) {
	genesis($opt_f);
	pre_upgrade();
	exit(0);
# just upgrade
} if ($u_flag) {
	print "Starting the upgrade\n";
	genesis(@CONFFILE);
	pre_upgrade();
	exit(0);
# just generate the answer files based on a custom file as an input
# by default, if this is not specified we will use @CONFFILE.
} if ($f_flag) {
	genesis($opt_f);
	exit(0);
} else {
	usage();
}

BEGIN {
        # check if this script is already running and if so just quit
        if (-e $LOCKFILE[0]) {
                open (LOCK, '<', @LOCKFILE) or die "@LOCKFILE exists but cannot be read! Check it's permissions.";
                my $running = <LOCK>;
                close LOCK;
                say "There is already an instance of poc-enabler running with PID $running.";
                exit(0);

        }
        open (LOCK, '>', @LOCKFILE);
        say LOCK $$;
        close LOCK;

        if (!background_check()) {
                unlink @LOCKFILE;
                exit(1);
        }
}

END {
        unlink @LOCKFILE;
}
