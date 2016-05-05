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

package Watch4net::Packages;
use Exporter qw(import);
use Switch;
use feature "state";

use Watch4net::Lookup qw(%block_tbl lookup); 
use Watch4net::Options;

our @EXPORT_OK = qw(is_installed do_install has_answers list_sp remove_sp);

# return the unique value only
sub return_unique
{
        my @input = @_;
        my @unique = do {
                                my %seen;
                                grep {!$seen{$_}++} @input
                        };
        return(@unique);
}

sub make_installed_tbl
{
        my (@installed_list);
        my $installed_targets_file = ".installed_targets";

	# if the .installed_targets exist do not try to recreate it.
        unless (-e $installed_targets_file) {
		print "Gathering information on which Solution Packs are installed ... \n";
                open(thisFH, '>', "$installed_targets_file") or die "\nCannot open the file: $_\n";
                @installed_list = `@APG_BIN/manage-modules.sh list installed`;
                print thisFH @installed_list;
                close(thisFH);
        }

        open(thisFH, '<', "$installed_targets_file") or die "\nCannot open the file: $_\n";

        # local arrays
        my (@fields, @sp) = "";
        while (my $line = <thisFH>) {
                if ($line =~ /Block|Meta/) {
                        @fields  = split(/\s+/, $line);
                        push @sp, lc("$fields[3]\n");
                }
        }
        close(thisFH);

        @::sp_installed = return_unique(@sp);
}

# check the existence of .answers files
sub has_answers
{
	my $thisSP = shift;

	# check if the answer file exist
       if (-e "conf/$thisSP.answers") {
	       return(1);
       } else {
               say "$thisSP.answer is missing!";
               return(0);
       }   
}

# check to see if the SolutionPack is installed
sub is_installed
{
        my ($target_name, $installed_targets_file, @installed_list);
	state $a_flag;

        $target_name = shift;
        $target_name =~ s/.answers//g;
        $installed_targets_file = ".installed_targets";
	#`rm -rf $installed_targets_file`;

	# generate the table containing the installed SPs
        make_installed_tbl();

        chomp($target_name);
        my @ret = grep(/$target_name/, @::sp_installed);

        # return 1 if the SolutionPack is currently installed
        # and 0 otherwise
        (@ret) ? 1 : 0;

	# what kind of inquiry do you have? If its a simple 'check' do not
	# bother trying to install anything
	my $inquiry = "";
	$inquiry = shift;

	if ($inquiry eq "check") {
		return(@ret);
	}

	# prompt the user if he wants to install this module
	if (!@ret && !$::a_flag) {
 		print "$target_name is not installed. Would you like to install it ? [y/n/quit]: ";
                        my $answer = <STDIN>;
                        chomp $answer;

			if ($answer eq "all") {
				$::a_flag = 1;
				return(0);
                        } if ($answer eq "n") {
				return(2);
                        } if ($answer eq "y") {
				return(0);
                        } if ($answer eq "quit") {
                                exit(0);
                        }
	}
        return(@ret);
}

sub do_install
{
        my ($target, $target_name);
        $target = shift;
        $target_name = shift;
        $target_name =~ s/.answers//g;
        chomp($target);

        # make sure we have something defined in the block hash before proceeding       
        my $ret = lookup($target_name, "block");
        if (defined($ret)) {
                foreach my $target_collector (@{$block_tbl{$target_name}}) {
                        # we skip all SolutionPacks defined with NOP's on %block_tbl
                        if ($target_collector ne "NOP") {
                                print "Installing " . $target_name .  ":$target_collector with answers from "
                                        . "$target\n";
                                system("@APG_BIN/manage-modules.sh install $target_collector $target_name --load=@APG_POC_DIR/conf/$target");
                        }
                }
        }
}

# list the installed SolutionPacks
sub list_sp
{
	system("@APG_BIN/manage-modules.sh list i");
	exit(0);
}

sub remove_sp
{
	my $target = shift;

	# before removing we need to know if it is actually installed
	# also delete the old installed_targets file who could confuse us
	if (".installed_targets") {
		`rm -rf .installed_targets`;
	}
	if (!is_installed($target, "check")) {
		print "Can't remove $target. Solution Pack is not installed!","\n";
		exit(0);
	}

	my $ret = lookup($target, "block");
	
	if (defined $ret) {
		foreach my $block (@{$block_tbl{$target}}) {
			print "Removing $target:$target-$block", "\n";
			system("yes | @APG_BIN/manage-modules.sh remove $block $target");
		}
	} else {
		# Seems like the requested SolutionPack was not found =(
		# print out all of the available Solution Packs for the 
		# user to choose from.
		foreach (keys %block_tbl) {
			print;
		}
	}
	exit(0);
}
