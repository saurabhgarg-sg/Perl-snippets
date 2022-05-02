#!/usr/local/bin/perl
use strict;

open(OUTPUT,"> C:\\Documents and Settings\\saurabhg\\Desktop\\shared\\comps.ldif") || die "cannot open output file".$!;

for(my $i=1;$i<=9999;$i++){
my $filername="F3050-204-".$i;
print OUTPUT "\ndn: CN=".$filername.",CN=Computers,DC=cifsqa2,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in";
print OUTPUT "\nchangetype: add";
print OUTPUT "\nobjectClass: top";
print OUTPUT "\nobjectClass: person";
print OUTPUT "\nobjectClass: organizationalPerson";
print OUTPUT "\nobjectClass: user";
print OUTPUT "\nobjectClass: computer";
print OUTPUT "\ncn: ".$filername;
print OUTPUT "\ndescription: Network Appliance Filer";
print OUTPUT "\ndistinguishedName:
 CN=".$filername.",CN=Computers,DC=cifsqa2,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in";
print OUTPUT "\nname: ".$filername;
print OUTPUT "\nobjectCategory:
 CN=Computer,CN=Schema,CN=Configuration,DC=cifsqa1,DC=lab,DC=eng,DC=btc,DC=neta
 pp,DC=in";
 print OUTPUT "\n";
#print OUTPUT "\nisCriticalSystemObject: FALSE\n\n";
}

close (OUTPUT);
