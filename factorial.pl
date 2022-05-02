#!/usr/bin/perl

use warnings;
use strict;

print "enter the number: ";
chomp(my $a=<STDIN>);

local $\="\n";
print eval join('*',(2..$a));
