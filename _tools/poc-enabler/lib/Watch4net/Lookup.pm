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

package Watch4net::Lookup;
use Exporter qw(import);
use Switch;
use v5.10;

our @EXPORT_OK = qw(lookup %block_tbl %name_tbl %collector_tbl %connection_tbl %types_tbl);
our (%block_tbl, %collector_tbl, %connection_tbl, %name_tbl, %types_tbl);

# this table wires each SolutionPack with it's required blocks to be used during 
# the install phase. 
# Format: meta, collect, reports, others
# Use 'NOP' if want to ignore one of these Solution Packs. e.g: Host => ['NOP']
%block_tbl = (
	'brocade-fc-switch'	=> ['brocade-fc-switch', 
				    'brocade-fc-switch-alerts', 
				    'brocade-fc-switch-reports', 
				    'brocade-fc-switch-snmp'],
	'cisco-mds-nexus'	=> ['cisco-mds-nexus', 
				    'cisco-mds-nexus-reports', 
				    'cisco-mds-nexus-snmp'],
        'generic-converged-infrastructure' => ['generic-converged-infrastructure-collect'],
	'emc-centera'		=> ['emc-centera', 
				    'emc-centera-collect', 
				    'emc-centera-reports'],
	'emc-ncm'		=> ['emc-ncm', 
				    'emc-ncm-collect', 
				    'emc-ncm-reports'],
	'emc-prosphere'		=> ['emc-prosphere',
				    'emc-prosphere-collect',
				    'emc-prosphere-events',
				    'emc-prosphere-reports'],
	'emc-vmax'		=> ['emc-vmax',
				    'emc-vmax-collect',
				    'emc-vmax-reports'],
	'emc-vnx-block'		=> ['emc-vnx',
				    'emc-vnx-collect',
				    'emc-vnx-reports'],
	'emc-vnx-file'		=> ['emc-vnx',
				    'emc-vnx-collect',
				    'emc-vnx-reports'],
	'emc-vplex'		=> ['emc-vplex',
				    'emc-vplex-collect',
				    'emc-vplex-reports'],
	'emc-watch4net-health'	=> ['emc-watch4net-health',
				    'emc-watch4net-health-collect',
				    'emc-watch4net-health-reports'],
	'hitachi-device-manager' => ['hitachi-device-manager',
				    'hitachi-device-manager-collect',
				    'hitachi-device-manager-reports'],
	'hp-storageworks-p9000'	=> ['hp-storage-works-p9000',
				    'hp-storageworks-p9000-collect',
				    'hp-storageworks-p9000-reports'],
	'hp3par-storeserv'	=> ['hp3par-storeserv',
				    'hp3par-storeserv-collect',
				    'hp3par-storeserv-reports'],
	'ibm-xiv'		=> ['ibm-xiv',
				    'ibm-xiv-collect',
				    'ibm-xiv-reports'],
	'microsoft-hyperv'	=> ['microsoft-hyperv',
				    'microsoft-hyperv-collect',
				    'microsoft-hyperv-reports'],
	'netapp-filer'		=> ['netapp-filer',
				    'netapp-filer-collect',
				    'netapp-filer-reports'],
	'oracle-database'	=> ['oracle-database',
				    'oracle-database-collect',
				    'oracle-database-reports'],
	'vmware-vcenter'	=> ['vmware-vcenter',
				    'vmware-vcenter-collect',
				    'vmware-vcenter-events',
				    'vmware-vcenter-reports'],
	'generic-rsc'		=> ['generic-rsc'],
        'snmp'                  => ['snmp'],
);

# this lookup hash translates the SolutionPack instance name with it's
# collector name. The update routine checks here to see what needs to be 
# updated
%collector_tbl = (
        'converged-infrastructure' => 'generic-converged-infrastructure-collect',
	'emc-centera'		=> 'emc-centera-collect', 
        'emc-ncm'               => 'emc-ncm-collect',
        'emc-prosphere'         => 'emc-prosphere-collect',
        'emc-vmax'              => 'emc-vmax-collect',
        'emc-vmax-unishere'     => 'emc-vmax-collect',
        'emc-vnx-block'         => 'emc-vnx-collect',
        'emc-vnx-file'          => 'emc-vnx-collect',
	'emc-vplex'		=> 'emc-vplex-collect',
        'emc-watch4net-health'  => 'emc-watch4net-health-collect',
	'generic-rsc'		=> 'generic-rsc',
        'hitachi-device-manager'=> 'hitachi-device-manager-collect',
	'hp3par-storeserv'	=> 'hp3par-storeserv-collect',
	'hp-storageworks-p9000'	=> 'hp-storageworks-p9000-collect',
        'ibm-xiv'               => 'ibm-xiv-collect',
	'microsoft-hyperv'	=> 'microsoft-hyperv-collect',
        'netapp-filer'          => 'netapp-filer-collect',
        'oracle-database'       => 'oracle-database-collect',
        'snmp'                  => 'snmp-collect',
        'vmware-vcenter'        => 'vmware-vcenter-collect',
);

# this table is used with the fix_want() function
%name_tbl = (
        'converged-infrastructure' => 'convergedinfrastructure',
        'emc-vmax'              => 'emcvmax.unisphere',
        'emc-vmax-unisphere'    => 'emcvmax.unisphere',
        'emc-vnx-block'         => 'vnx',
        'emc-vnx-file'          => 'vnx',
        'generic-rsc'           => 'genericrsc.host',
        'hitachi-device-manager'=> 'hds.devicemanager',
        'ibm-xiv'               => 'ibmxiv.array',
        'microsoft-hyperv'      => 'microsoft.hyperv',
        'netapp-filer'          => 'netapp',
        'oracle-database'       => 'oracle.database',
        'snmp'                  => 'snmp',
        'vmware-vcenter'        => 'connection',
);

# this hash contains the information related to the connectivity checks for each
# SolutionPack
%connection_tbl = (
        'emc-vmax'              => ['network-ip:unisphere.*host=(.*)',
                                    'network-auth-user:unisphere.*username=(.*)',
                                    'network-auth-passwd:unisphere.*password=(.*)',
                                    'network-extra:symapi.(port=.*)',
                                    'network-extra:symapi.(security=.*)',
                                    'network-protocol:solutions_enabler'],

        'emc-vnx-file'          => ['network-ip:vnx.*csprimary.*=(.*)',
                                    'network-auth-user:vnx.*username=(.*)',
                                    'network-auth-passwd:vnx.*password=(.*)',
                                    'network-protocol:navisphere'],

        'emc-vnx-block'         => ['network-ip:vnx.*spa.*=(.*)',
                                    'network-auth-user:vnx.*username=(.*)',
                                    'network-auth-passwd:vnx.*password=(.*)',
                                    'network-protocol:navisphere'],

        'generic-rsc'		=> ['network-ip:host.*hostname=(.*)',
				    'network-auth-user:host.*username=(.*)',
				    'network-auth-passwd:host.*password=(.*)',
				    'network-os:host.*os=(.*)',
				    'network-protocol:rsc'],

        'hitachi-device-manager'=> ['network-ip:hds.*host.*=(.*)',
                                    'network-port:hds.*port=(.*)',
                                    'network-auth-user:hds.*username.*=(.*)',
                                    'network-auth-passwd:hds.*password.*=(.*)',
				    'network-protocol:soap'],

        'ibm-xiv'               => ['network-ip:array.*host.*=(.*)',
                                    'network-auth-user:array.*username.*=(.*)',
                                    'network-auth-passwd:array.*password.*=(.*)'],

        'vmware-vcenter'        => ['network-ip:vcenter.host=(.*)',
				    'network-auth-user:vcenter.username=(.*)',
				    'network-auth-passwd:vcenter.password=(.*)',
				    'network-protocol:www'],

        'netapp-filer'          => ['network-ip:netapp.*ip=(.*)',
				    'network-auth-user:netapp.*username=(.*)',
				    'network-auth-passwd:netapp.*password=(.*)',
				    'network-protocol:ssh'],

        'snmp'                  => ['network-ip:device.*hostname=(.*)',
                                    'network-auth-user:device.*password=(.*)',
                                    'network-extra:device.*version=(.*)',
                                    'network-extra:device.*type=(.*)',
                                    'network-protocol:snmp'],
);

# this hash will be used in places such as OS types for the generic-src sp, where 
# the input answers file is the same for all OSes (Unix) but the internals of the 
# SolutionPack differ, e.g: shell commands could be OS specific.
%types_tbl = (
	'generic-rsc'		=> ['AIX:0', 'HPUX:1', 'LINUX:2', 'SOLARIS:3', 'WINDOWS:4'],
        'netapp-filer'          => ['7-MODE:0', 'CLUSTER-MODE:1'],
);

# this is a dispatcher for the tables. We look to match 
# the SolutionPack name with its property 
sub lookup 
{ 
        my ($self, $name, $table, $is_valid);
        ($self, $table) = @_; 
	
	# sanity check. is this a valid SolutionPack?	
	$is_valid = grep(/$self/, (keys %block_tbl));

	if ($is_valid) {
        	switch ($table) { 
        		case "block" 		{ $name = @{$block_tbl{$self}}};
        		case "connection" 	{ $name = @{$connection_tbl{$self}}};
        		case "collector"	{ $name = $collector_tbl{$self}};
        		case "name" 		{ $name = $name_tbl{$self}};
        	} 
        	return $name; 
	} else { 
		say "$self is not a valid Solution Pack\n";
		say "Please choose from the following:";
		say "\t" . $_ foreach(keys %block_tbl);
		exit(0);
	}
}

return(1);
