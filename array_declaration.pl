#!/usr/bin/perl

use strict;
use warnings;

my @stuff = qw/a b c/;
my @things = (1,2,3,4);
my $onething = "this is a scalar";
my @allofit = (@stuff, @things, $onething);    #this now contains 8 elements: a,b,c,1,2,3,4 & "this is a scalar"

foreach my $element (@allofit) {
	print "$element\n";
}


