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

package Watch4net::Error;
use Exporter qw(import);
use Term::ANSIColor;

our @EXPORT_OK = qw(error_facility info_msg ok_msg p_debug);

sub error_facility
{
        my ($severity, $msg, $thisSP) = @_;
        my $now = `date +"[%Y-%m-%d %T %Z]"`;
        chomp($now);

        open(LOG_FH, '>>', "logs/$thisSP-connectivity.log") or die "\nCannot open $thisSP-connectivity.log\n";

        # to the STDOUT
        printf  "%-5s -- %s -- %s\n", $severity, $now, $msg;
        # now to a file
        printf LOG_FH "%-5s -- %s -- %s\n", $severity, $now, $msg;
        close(LOG_FH);
}

sub ok_msg
{
	my ($message, $type) = @_;
	format STDOUT =
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<   		  	@>>>>>>>>>>>>>>>>>>>
"$message",  								                        "[$type]"
.
write;

}

sub p_debug
{
	my @msg = shift;
	printf "DEBUG ::: @msg\n";
}

return 1;
