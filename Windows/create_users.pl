#!/usr/local/bin/perl
use strict;

open(OUTPUT,"> C:\\Documents and Settings\\saurabhg\\Desktop\\shared\\users.ldif") || die "cannot open output file".$!;

#for(my $i=0;$i<=2000;$i++){
     #   my $basename="C".$i;
           for(my $j=1;$j<=2000;$j++){
            #    my $username=$basename."F".$j;
                my $username="user".$j;
                print "\n$username";
                print OUTPUT "\ndn: CN=".$username.",CN=Users,DC=admig,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in";
                print OUTPUT "\nchangetype: add";
                print OUTPUT "\ncn: ".$username;
                print OUTPUT "\nobjectClass: user";
                print OUTPUT "\nsamAccountName: $username";
                print OUTPUT "\n>givenname: $username";
                print OUTPUT "\n>sn: $username";
                print OUTPUT "\nuserAccountControl: 66048";
                 print OUTPUT "\n";
                 }
#}

close (OUTPUT);
