#!/usr/bin/perl

######################################################################################################################
# The script that manipulates the properties of Solutions Enabler Event Daemon process. 							 #
# The input parameters for this script are the event daemon process options file, the SNMP Trap Listener Client      #
# host, port and list of Symmetrix ids to register the events for.                                                   #
# Usage: convert_options.pl <daemon options file> <snmp trap client host/ip> <snmp trap client port>                 #
# [sids=<comma delimited list of symmetrix ids>]                                                                     #
#																													 #
# Inserts or Modifies the property storevntd:SNMP_TRAP_CLIENT_REGISTRATION to include the client host and port.      #
# Inserts or Modifies the property storevntd:LOG_EVENT_TARGETS to define the "snmp" target.                          #
# Inserts or Modifies the property storevntd:LOG_SYMMETRIX_EVENTS to register the given symmetrix ids with the list  #
# of predefined events related to health of the system.                                                              #
######################################################################################################################

use List::Util qw(first);

# number of arguments given to script
$numArgs = scalar(@ARGV);
 
# print usage information
if( $numArgs < 3 ) {
   print "The arguments must be at least 3, the input file name, hostname of the listener, port of the listener \n";
   print "Optionally the list of symmetrix ids can be added to register for events using the format sids=<comma separated list of symmetrix ids>. \n";
   exit;
}
my $filename = $ARGV[0];  # file to change
my $listenerhost = $ARGV[1]; # listener for daemon events
my $listenerport = $ARGV[2]; # listener for host

# If list of sids is given, extract the list of sids alone
my $sids = undef;
if($numArgs == 4) {
	$sids = substr $ARGV[3], 5; # optional argument to include the events for sids
}

#Open the file handle and get all property definitions (options) and option sections in comment form
#The comment sections are useful to find so appropriate options are inserted in right section when they are not defined.
my @odata = openfile($filename);
my $compattern = "^#";
my @options = grep(!/$compattern/, @odata); # list of non-comments (properties)
my @comments = grep(/$compattern/, @odata); # list of comments

# declaration of global variable so we don't need to pass this around, but this
# has to be set with right value in each of these enhance functions to make it work.

# The variable that defines the following. Once the property found to be modified, do we need to loop
# till the end of its value statements to find out the index of the line (statement) where the supplied propery value has
# to be appended. '1' indicates multiple values and needs scanning till the end and '0' indicates single value and needs to
#check only that value.
my $loopForDataTillEnd=1; 

# Inserts or Modifies the property storevntd:SNMP_TRAP_CLIENT_REGISTRATION to include the client host and port.
enhanceSNMPclientparam();

# Inserts or Modifies the property storevntd:LOG_EVENT_TARGETS to define the "snmp" target.       
enbleSNMPTrap();

# Inserts or Modifies the property storevntd:LOG_SYMMETRIX_EVENTS to register the given symmetrix ids with the list  #
# of predefined events related to health of the system. 
if($sids) {
	defineSymmetrixEvents();
}

#Finally write the modified data to the same file.
writefile($filename,@odata);

exit(1);

##########################################################################################
# Open a file
#
sub openfile {
	my $filename = shift;
	open(FILE, $filename) or die("Unable to open file:  $!");
	@odata = <FILE>; 
	close(FILE);
	return @odata;
}
#
##########################################################################################
# write a file and unlimk file
#
sub writefile {
	my ($filename, @data) = @_;
	print "filename to unlink = $filename \n";
	unlink $filename;
	sleep 1;
	open FILE, "> $filename" or die ("This file will not open! $!");
	print FILE  @data;
	close(FILE);
}
#
##########################################################################################
# Get the index of the given string object in the global array of data
#
sub getindex {
	my $chkstr = shift;
	print "String to check = $chkstr[0] \n";
	return first { @odata[$_] eq $chkstr} 0..$#odata;
}
#
##########################################################################################
# Get the index of the given string object in the global array of data
#
sub appenddata {
	my @params = @_;
	my $index = $params[0];
	my $insLocPattern = $params[1];
	my $chkPositive = $params[2];
	my $strToAppend = $params[3];
	my $insNewLine = $params[4];	
	my $insBefore = $params[5];
	my $strToInsert = $params[6];
	
	while($index <= $#odata)
	{
		my @search;		
		if($chkPositive) {
		    print "searching for positive match for $insLocPattern in $odata[$index] \n";
			@search = grep(/$insLocPattern/, $odata[$index]);
		}
		else {
			print "searching for negative match for $insLocPattern in $odata[$index] \n";
			@search = grep(!/$insLocPattern/, $odata[$index]);
		}
		if(@search)
		{
		    print "found matching statement to manipulate at $index \n";
            # Modify the matching property with continuation string			
			if($strToAppend) {				
				$odata[$index] =~ s/\s+$//;  #trim all trailing spaces
				$odata[$index] .= " ".$strToAppend."\n";	
			}
			
			#Insert the new property or new property value for the option
			if($insNewLine)
			{
				my $newindex;
				if($insBefore) {				
				   $newindex = $index;
				}
				else {
				   $newindex = $index + 1;
				}
				print "New index to insert: $newindex \n";			
				splice @odata, $newindex, 0, $strToInsert."\n";
			}
			last;
		}
		else {
			# If we need to search for the pattern in the next lines until we find the match,
			# we will loop, otherwise we will just verify the matching line of the given index and exit 
			# out of while loop.
			if($loopForDataTillEnd) {
				$index++;
			}
			else {
				last;
			}
		}
	}

	print "Final modified data: \n";	
	print $odata[$index-1], "\n";
	print $odata[$index], "\n";
	print $odata[$index+1];
	
	return;
}
#
##########################################################################################
# Verifies whether the given property exists either in option parameters or in comments 
# depending on the supplied flag. If <isOptions> is '1', then it searches in property options
# data otherwise in comment sections.
#
sub getmatches {
	my ($chkStr, $isOptions) = @_;	
	my @result;
	
	print "String to Match: ", $chkStr, "\n";
	print "Is Options: ", $isOptions, "\n";
	
	if($isOptions) {		
		@result = grep(/$chkStr/, @options);		
	}
	else {		
		@result = grep(/$chkStr/, @comments);		
	}
		
	return @result;
}
#
##########################################################################################
# Verify the property in the options properties or comments and append the data appropriately.
#
sub verifyappenddata {
	my @params = @_;
	my $strToMatch = $params[0];
	my $isOptions = $params[1];
	my $insLocPattern = $params[2];
	my $chkPositive = $params[3];
	my $strToAppend = $params[4];
	my $insNewLine = $params[5];	
	my $insBefore = $params[6];
	my $strToInsert = $params[7];
	
	print "String to Match: ", $strToMatch, "\n";
	print "Is Options: ", $isOptions, "\n";
	print "Pattern to check insert location: ", $insLocPattern, "\n";
	print "Positive Match?: ", $chkPositive, "\n";
	print "String to Append to matched line: ", $strToAppend, "\n";
	print "Insert New Line?: ", $insNewLine, "\n";
	print "Insert Before?: ", $insBefore, "\n";
	print "Insert String?: ", $strToInsert, "\n";

	# Find the matched properties for the given property name to match.
	my @matches = getmatches($strToMatch, $isOptions);
		
	if(@matches)
	{		
		my $index = getindex($matches[0]);		
		print "Found property at $index \n";
	
		appenddata($index, $insLocPattern, $chkPositive, $strToAppend, $insNewLine, $insBefore, $strToInsert);
	}	
		
	return @matches;
}
#
##########################################################################################
# Print given array
#
sub printarray {
	my @params = @_;
	
	foreach $line (@params)
	{
		print $line;
	}	
}
#
##########################################################################################
# Verify if storevntd:SNMP_TRAP_CLIENT_REGISTRATION property exists or not. If exists, append the new client
# If not create the property in the right section. If the section is not found, append to the bottom of the file.
#
sub enhanceSNMPclientparam {
	my $snmp_client_key = "storevntd:SNMP_TRAP_CLIENT_REGISTRATION";
	my $filter_level = "10";
	my $state = "ACTIVE";
	my $snmp_new_client = $listenerhost.",".$listenerport.",".$filter_level.",".$state;
	
	# Find the existence of the client in the file, if exists, return. Assumes that the format of client definition exists only in
	# SNMP_TRAP_CLIENT_REGISTRATION property and doesn't check for the property name with the value.
	my @search = grep(/$snmp_new_client/, @options);
	
	if(@search) {
		return;
	}
	
	# Once the matching property is found, loop through the end of the file until the last value statement is found for appending.
	# In case of SNMP property, the property may exist in the following format and we need to find the last row without '\'
	# storevntd:SNMP_TRAP_CLIENT_REGISTRATION = 10.247.59.135,1999,10,ACTIVE \
    #										  10.247.65.138,1555,10,ACTIVE \
    #										  10.247.65.139,1555,10,ACTIVE 
	$loopForDataTillEnd = 1;

	# Check in property options
	my @snmp = verifyappenddata($snmp_client_key, 1, "\\\\", 0, "\\", 1, 0, $snmp_new_client);

	if(!@snmp) {	
		# Check in sectional comments to find the matching section.
		@snmp = verifyappenddata($snmp_client_key, 0, "^#----|^#####", 1, undef, 1, 1, $snmp_client_key." = ".$snmp_new_client);	
		# If none found, append to the end of the file.
		if(!@snmp) {
			push(@odata, $snmp_client_key." = ".$snmp_new_client."\n");
		}
	}	
}
#
##########################################################################################
# Verify if storevntd:LOG_EVENT_TARGETS property exists or not. If exists, verify if 'snmp' target exists or not.
# If exists, no action. If not, append 'snmp' to it.
# If not create the property in the right section. If the section is not found, append to the bottom of the file.
#
sub enbleSNMPTrap {
	my $snmp_log_key = "storevntd:LOG_EVENT_TARGETS";
	
	my $snmp_target = "snmp";
	my $file_target = "file";
	
	# Once the matching property is found, we don't want to loop through, we need to check for existance of 'snmp' only in that line.
	# the property exists in the following format 
	# storevntd:LOG_EVENT_TARGETS = snmp file    
	$loopForDataTillEnd = 0;

	# Check in property options
	my @snmp = verifyappenddata($snmp_log_key, 1, $snmp_target, 0, $snmp_target, 0, 0, undef);

	# Check in sectional comments to find the matching section if not found in options
	if(!@snmp) {	 
	    # When we are searching for the section in the comments, we need to search for beginning of next section
		# before incorporating the property, so we loop.
	    $loopForDataTillEnd = 1;
		@snmp = verifyappenddata($snmp_log_key, 0, "^#----|^#####", 1, undef, 1, 1, $snmp_log_key." = ".$snmp_target." ".$file_target);	
		# If none found, append to the end of the file.
		if(!@snmp) {
			push(@odata, $snmp_log_key." = ".$snmp_target." ".$file_target."\n");
		}
	}	
}
#
##########################################################################################
# Verify if given sid is present as an option of "storevntd:LOG_SYMMETRIX_EVENTS". If exists no change. If not, add
# that as an option in the corresponding section appropriately.
#
sub defineSymmetrixEvents {
	my $sym_events_key = "storevntd:LOG_SYMMETRIX_EVENTS";
	my $events = "disk, device, device pool, director,  srdf consistency group, srdfa session, srdf link, srdf system, service processor, environmental, diagnostic, checksum, status, events, array subsystem, groups, optimizer, thresh_critical=3, thresh_major=2, thresh_warning=1, thresh_info=0;";
	
	my $sym_events = "";
	
	my @symids = split(",", $sids);		
	# Check if the given sid is already defined, if definesd skip that, otherwise define the events.
	# Note that it doesn't check for the property name, rather it checks for existance of 'sid=<sid>' and assumes it only exists in 
	# storevntd:LOG_SYMMETRIX_EVENTS
	foreach my $sid (@symids) {
	    my $sid_pattern = "sid=".$sid;
		my @search = grep(/$sid_pattern/, @options);
		if(!@search) {
			if( length($sym_events) > 0) {
				$sym_events .= " \\ \n";
			}
			$sym_events .= $sid_pattern.",".$events;
		}		
	}
	# If there are some symmetrix ids which needs to register for events, define those.	
	if(length($sym_events) > 0)  {	
							
		# The property storevntd:LOG_SYMMETRIX_EVENTS registers multiple symmmetrix arrays, so we need to loop through
		# to find the last value to append the new values.
		$loopForDataTillEnd = 1;

		# check in the property options
		my @sym_key = verifyappenddata($sym_events_key, 1, "\\\\", 0, "\\", 1, 0, $sym_events);
		
		# if not found check in the comment sections
		if(!@sym_key) {	 
			@sym_key = verifyappenddata($sym_events_key, 0, "^#----|^#####", 1, undef, 1, 1, $sym_events_key." = ".$sym_events);	
			
			#if not found insert at the end.
			if(!@sym_key) {
				push(@odata, $sym_events_key." = ".$sym_events."\n");
			}
		}	
	}
}
#
##########################################################################################
