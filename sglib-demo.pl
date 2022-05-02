#!/usr/local/bin/perl

unshift (@INC, "./sglib/"); # Prepend a directory name
require 'names.pl';

# Demo of genLongNames

for(my $power=3;$power <=10;$power++){
my $looper = 2**$power;
print "\n".names::genLongNames($looper);

}
