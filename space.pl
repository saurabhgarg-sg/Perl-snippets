#!/usr/bin/perl

use strict;

open( INPUT,  $ARGV[0] )     || die "cannot open input file $ARGV[0]";
open( OUTPUT, "> $ARGV[1]" ) || die "cannot open output file $ARGV[1]";
while ( defined( my $line = <INPUT> ) ) {
    $line =~ s/^\s//;
    print OUTPUT $line;

}
close(INPUT);
close(OUTPUT);
