#!/usr/bin/perl

use strict;
use warnings;

#============= main =====================#

print "Enter the number:";
my $number=<STDIN>;
chomp $number;

my $n=1;
my $max_factors;
my $max_count=1;

$,=",";$\="\n",$"=", ";

while($n++ < $number){
my @factors=(1);
my $looper=1;
my $mod;
while ($looper++ < $n-1) {
        $mod = $n%$looper;
                if($mod == 0){
			push(@factors,($looper));	
                        }
	}
	
	if(@factors > $max_count)
	{
	$max_count = @factors;
	$max_factors = $n;
	}
	
	print "$n: @factors";
	
}

print "\n $max_factors has got the maximum factors $max_count";
#============= main ends =====================#
