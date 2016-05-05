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

package Watch4net::Options;
use Exporter qw(import);

our @ISA = qw(Exporter);
our @EXPORT = qw(
        $FORCE_INSTALL_CHECK    $VERBOSE                @APG_BIN        @APG_PREFIX
        @APG_POC_DIR            @CONFFILE               @JAVA_BIN       @LOCKFILE
        @NAVISPHERE_DIR         @REMOTE_RSC_INSTANCE    @REMOTE_RSC_DIR @SYMAPI_CONF
);

our (
        $FORCE_INSTALL_CHECK,   $VERBOSE,               @APG_BIN,       @APG_PREFIX,
        @APG_POC_DIR,           @CONFFILE,              @JAVA_BIN,      @LOCKFILE,
        @NAVISPHERE_DIR,        @REMOTE_RSC_INSTANCE,   @REMOTE_RSC_DIR,@SYMAPI_CONF
);

# boolean options goes here
$FORCE_INSTALL_CHECK = 0;
$VERBOSE = 0;

# env options
@APG_PREFIX     = "/opt/APG";
@APG_POC_DIR    = "@APG_PREFIX/PoC/";
@APG_BIN        = "@APG_PREFIX/bin/";
@CONFFILE       = "w4n_poc.csv";
@JAVA_BIN       = "@APG_PREFIX/Java/Sun-JRE/6.0u37/bin/java";
@LOCKFILE       = "poc-enabler.lock";

# technology specifics

# Solutions Enabler
@SYMAPI_CONF = "/var/symapi/config/netcnfg";

# Navisphere
@NAVISPHERE_DIR = "/opt/Navisphere";

# Remote-Shell-Collector
@REMOTE_RSC_INSTANCE    = "Generic-RSC";
@REMOTE_RSC_DIR         = "@APG_PREFIX/Collecting/Remote-Shell-Collector/@REMOTE_RSC_INSTANCE";

return 1;
