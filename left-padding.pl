#!/usr/bin/perl

use strict;
use warnings;

gen_numbers(3);
gen_numbers(30);
gen_numbers(300);
gen_numbers(3000);
gen_numbers(30000);
gen_numbers(300000);
gen_numbers(3000000);

sub gen_numbers{
my $number = shift;

my @num_array = split(//,$number);
#print $_."\n" foreach (@num_array) ;
my $final_number = "0"x(10-$#num_array) ;
$final_number .= $number; 
print ("\n$final_number") ;
}