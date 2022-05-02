#!/usr/local/bin/perl

use strict;
use warnings;

my @junks = qw/DVDRip Xvid (\d)?CDrip DDR CD DVD DVDSCR Eng aXXo scr keltz extrascene smeet torrent torrentz zektorm Stealthmaster DivXLTT noir fxm moviez norar mxmg nodlabs torentz NOTV haggis fxw  FQM fxg P0w4 BRRip ac3 wlh neroz morsan HDTV LOL maxspeed 3xforum \{.*\} \[\] \(\) \- \~/;
my ($words, $filecount);

opendir( DIR, $ARGV[0] );
my @files = grep( /.(mp4|avi|mkv|divx|srt|sub)/, readdir(DIR) );
closedir(DIR);

foreach my $file (@files) {
    my $newfilename = $file;

    map { $newfilename =~ s/($_){1,}//ig; } @junks;
    $newfilename =~ s/(\s){2,}/ /ig;
    $newfilename =~ s/(\.){2,}/\./g;
    #$newfilename =~ s/\D\d(\D){1,}\./\./ig;
     if($file ne $newfilename){
        print "\n" . $file . "\t" . $newfilename;
        $words += length($file) - length($newfilename);
        $filecount++;
    }
    
    rename( $ARGV[0] . "\\" . $file, $ARGV[0] . "\\" . $newfilename );
}

print "\nTotal $words words deleted \n $filecount files modified" if($filecount && $words);

