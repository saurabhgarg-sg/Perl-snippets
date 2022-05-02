#!/usr/local/bin/perl

use warnings;
use strict;


 for(my $i=0;$i<=15;$i++)
 {
        print "\n".dec2bin($i);
}

sub dec2bin {
    my $str = unpack("B8", pack("v", shift));
    $str =~ s/^0{4}//;   # otherwise you'll get leading zeros
    return $str;
}
