#!/usr/local/bin/perl

use strict;
use warnings;

use Win32::TieRegistry (Delimiter=>"/")  ;

my $swKey       =       $Registry->{"LMachine/SYSTEM/CurrentControlSet/Control/Lsa"}       ;
my $keyValue    =       $swKey->{"lmcompatibilitylevel"}       ;

print "Registry value is : $keyValue"   ;

#set it to 1
$swKey->{"lmcompatibilitylevel"}        =       [ pack("L",0), "REG_DWORD" ]    ;
$keyValue    =       $swKey->{"lmcompatibilitylevel"}       ;

print "\nRegistry value is : $keyValue"   ;


