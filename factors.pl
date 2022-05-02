#!/usr/bin/perl

use strict;
use warnings;

#============= main =====================#

print "Enter the number:";
my $n=<STDIN>;
chomp $n;

my @factors=(1);
my $looper=1;
my $mod;

while ($looper < $n-1) {
        $looper += 1;           
        $mod = $n%$looper;
                
                if($mod == 0){
                        @factors = (@factors,$looper);
                        }
}
$, = "\t";$\="\n";
print @factors;
#============= main ends =====================#