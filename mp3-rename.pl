#!/usr/local/bin/perl

use strict;
use warnings;

my $extn = "mp3";

opendir( DIR, $ARGV[0] );
my @files = grep( /.$extn$/, readdir(DIR) );
closedir(DIR);

print "\nFiles with Extension " . $extn . " in Directory are:";
foreach my $file (@files) {
    print "\n" . $file;
    my $newfilename = $file;
    $newfilename =~ s/ @ Fmw11.com//i;
    rename( $ARGV[0] . "\\" . $file, $ARGV[0] . "\\" . $newfilename );
}

