#!/usr/bin/perl

#Execute the perl script that sets the appropriate configuration for 'storevntd' daemon
unshift (@ARGV, "convert_options.pl");
unshift (@ARGV, "perl");

#Execute the command
system (@ARGV);

#On Success, execute the daemon command to reload the new daemon options
if ($? == -1) {
        print "Failed to execute: $!\n";
}
elsif ($? & 127) {
	printf "$! died with signal %d, %s coredump\n",
		($? & 127),  ($? & 128) ? 'with' : 'without';
}
else { # success
	printf "child exited with value %d\n", $? >> 8;
	system("stordaemon action storevntd -cmd reload");
}