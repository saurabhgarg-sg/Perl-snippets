#!/usr/bin/perl

use File::Find;

find(\&wanted,'/u/saurabhg/web/tests');

sub wanted{
print "\n$_" unless /^\.{1,2}$/ ;
print "\n$File::Find::name" unless /^\.{1,2}$/ ;

}
