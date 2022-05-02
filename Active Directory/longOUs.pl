#!/usr/local/bin/perl
#perl script to generate vbs script for creating long ou list
#the created vbs script should be run locally on AD server

#Set objDomain = GetObject("LDAP://DC=cifsqa3,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in")
#Set objOU = objDomain.Create("organizationalUnit", "ou=HR")
#objOU.SetInfo

open(FILE,"> longOUs.vbs")      || die "cannot create the target vb script"     ;
print FILE q/Set objDomain = GetObject("LDAP:\/\/DC=cifsqa3,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in")/      ;
 print FILE "\n"        ;
my $last = "ou=Testing_OU"      ;
print FILE q/Set objOU = objDomain.Create("organizationalUnit", "ou=Testing_OU")/       ;
print FILE "\n"        ;
print FILE q/objOU.SetInfo/;
print FILE "\n"        ;

#max permitted ou name = abcdefghijklmnopqrstuvwxABCDEFGHIJKLMNOPQRSTUVWX0123456789abcdef
print FILE q/Set objDomain = GetObject("LDAP:\/\/ou=Testing_OU,DC=cifsqa3,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in")/      ;
 print FILE "\n"        ;
 
#create large list of OUs here 1024
my $start="LDAP:\/\/"   ;
my $currOU="abcdefghijklmnopqrstuvwxABCDEFGHIJKLMNOPQRSTUVWX012345671"  ;

for(my $counter=0;$counter<=1024;$counter++)
{
  my $tempOU = $currOU.$counter         ;
 print FILE "\n"        ;
 print FILE "Set objOU = objDomain.Create(\"organizationalUnit\", \"ou=".$tempOU."\")\n"       ;
 print FILE q/objOU.SetInfo/;
  print FILE "\n"        ;
}


close FILE;
