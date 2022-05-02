#!/usr/local/bin/perl
#perl script to generate vbs script for creating long ou list
#the created vbs script should be run locally on AD server

#Const ADS_GROUP_TYPE_LOCAL_GROUP = &h4
#Const ADS_GROUP_TYPE_SECURITY_ENABLED = &h80000000
#Const ADS_PROPERTY_APPEND = 3

#Set objOU = GetObject("LDAP://DC=cifsqa1,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in")
#Set objGroup = objOU.Create("Group", "cn=grp1")
#objGroup.Put "sAMAccountName", "grp1"

#objGroup.Put "groupType", ADS_GROUP_TYPE_LOCAL_GROUP Or ADS_GROUP_TYPE_SECURITY_ENABLED
#objGroup.PutEx ADS_PROPERTY_APPEND, "member",Array("cn=burt 172407,cn=users,DC=cifsqa1,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in")
#objGroup.SetInfo

use strict;
use warnings;

my $user       = "rpctestuser";
my $domainName = "lcq";

open( FILE, "> groupsAndUser.vbs" ) || die "cannot create the target vb script";
print FILE q[Const ADS_GROUP_TYPE_LOCAL_GROUP = &h4];
print FILE qq[\n];
print FILE q[Const ADS_GROUP_TYPE_SECURITY_ENABLED = &h80000000];
print FILE qq[\n];
print FILE q[Const ADS_PROPERTY_APPEND = 3];
print FILE qq[\n];
print FILE qq[\n];

for ( my $i = 1 ; $i < 19999 ; $i++ ) {
    my $group = "grp" . $i;
    print FILE q[Set objOU = GetObject("LDAP://DC=]
      . $domainName
      . q[,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in")];
    print FILE qq[\n];
    print FILE qq[Set objGroup = objOU.Create("Group", "cn=$group")];
    print FILE qq[\n];
    print FILE qq[objGroup.Put "sAMAccountName", "$group"];
    print FILE qq[\n];
    print FILE
q[objGroup.Put "groupType", ADS_GROUP_TYPE_LOCAL_GROUP Or ADS_GROUP_TYPE_SECURITY_ENABLED];
    print FILE qq[\n];
    print FILE q[objGroup.PutEx ADS_PROPERTY_APPEND, "member",Array("cn=]
      . $user
      . q[,cn=users,DC=]
      . $domainName
      . q[,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in")];
    print FILE qq[\n];
    print FILE q[objGroup.SetInfo];
    print FILE qq[\n];
}

close FILE;

