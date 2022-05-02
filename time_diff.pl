#!/usr/local/bin/perl

#my $tstamp = time();
#print $tstamp, "\n";
#print scalar localtime($tstamp), "\n";

#my ($y, $m, $d, $ss, $mm, $hh) = (localtime($tstamp))[5,4,3,0,1,2];
#$y += 1900;
#$m += 1;
#print "y=$y / m=$m / d=$d - $hh\:$mm\:$ss\n";

##------------------- time diff in mins and secs --------------------#
#my $past   = $tstamp;
#sleep (3)       ;
#my $diff = time() - $past;
#my $mDiff = int($diff / 60);
#my $sDiff = sprintf("%02d", $diff - 60 * $mDiff);
#print "diff = $diff -> $mDiff\:$sDiff\n";

use strict;
use warnings;

my $start       =       time()          ;
sleep(5)      ;
my $diff        =       time() - $start       ;

print $diff     ;

