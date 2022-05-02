#!/usr/local/bin/perl

use strict;
use warnings;

opendir( DIR, $ARGV[0] );
my @files = grep( //, readdir(DIR) );
closedir(DIR);

foreach my $file (@files) {
    if ( -f $file ) {
        print "\n" . $file;
        my $newfilename = $file . "\.tar";
        print "-->" . $ARGV[0] . "\\" . $newfilename;

        rename($ARGV[0]."\\".$file,$ARGV[0]."\\". $newfilename);
    }
}

