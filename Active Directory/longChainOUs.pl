#!/usr/local/bin/perl
#perl script to generate vbs script for creating long ou list
#the created vbs script should be run locally on AD server

use strict;
use warnings;

open( FILE, "> longChainOUs.vbs" ) || die "cannot create the target vb script";
print FILE
q/Set objDomain = GetObject("LDAP:\/\/DC=lcq,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in")/;
print FILE "\n";
my $last = "gpo";
print FILE q/Set objOU = objDomain.Create("organizationalUnit", "ou=gpo")/;
print FILE "\n";
print FILE q/objOU.SetInfo/;

#max permitted ou name = abcdefghijklmnopqrstuvwxABCDEFGHIJKLMNOPQRSTUVWX0123456789abcdef

#create large list of OUs here 1024
my $prefix = "LDAP:\/\/ou=";
my $currOU = "abcdefghijklmnopqrstuvwxABCDEFGHIJKLMNOPQRSTUVWX0123456789abcdef";
my $suffix = ",DC=lcq,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in\")";

for ( my $counter = 0 ; $counter <= 32 ; $counter++ ) {
    my $tempContext = $prefix . $last . $suffix;
    print FILE "\n";
    print FILE ("Set objDomain = GetObject(\"$tempContext");
    print FILE "\n";
    print FILE "Set objOU = objDomain.Create(\"organizationalUnit\", \"ou="
      . $currOU . "\")\n";
    print FILE q/objOU.SetInfo/;
    print FILE "\n";
    $last = $currOU . ",ou=" . $last;
}

close FILE;
