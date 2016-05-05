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

PREFIX 	  = /opt/APG
APG_POC_DIR = ${PREFIX}/PoC
POC_DIRS  = conf extra lib/Watch4net logs
GREP	  = /bin/egrep
MANDIR	  = /usr/share/man/man8

install: 
	@echo "Installing poc-enabler"
	@install -o apg -g apg -m 0555 -d $(APG_POC_DIR)

	@for i in ${POC_DIRS} ; do \
		install -o apg -g apg -m 0555 -d $(APG_POC_DIR)/$$i ; \
	done

	@for i in extra lib/Watch4net ; do \
		install -o apg -g apg -m 0555 $$i/* $(APG_POC_DIR)/$$i ; \
	done

	@install -o apg -g apg -m 0555 poc-enabler.pl $(APG_POC_DIR)
	@install -o apg -g apg  -m 0444 docs/poc-enabler.8 $(MANDIR)
	@gzip $(MANDIR)/poc-enabler.8
	@echo "Done!"

clean:
	@echo "Removing poc-enabler"
	@rm -rf $(MANDIR)/poc-enabler.8.gz
	@rm -rf $(APG_POC_DIR)
