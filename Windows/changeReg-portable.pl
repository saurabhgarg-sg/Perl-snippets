#!/usr/local/bin/perl

use strict;
use Win32::Registry     ;

GetRegValue()   ;

sub GetRegValue{
my $mykey =  "lmcompatibilitylevel"       ;
my $key         =       "  "   ;
my $hashRef     =       undef   ;
my %vals        =       undef   ;
my $node        =       undef   ;

# these two lines are used to connect to remote machine
#But it does not work as for most of the machines remote registry access
#is disabled for anonymous users by default

#$::HKEY_LOCAL_MACHINE->Connect("\\\\10.72.205.151",$node)  || die "cannot network: $^E"        ;
#$node->Open("SYSTEM\\CurrentControlSet\\Control\\Lsa\\", $hashRef) ||  die "Open: $^E";

$::HKEY_LOCAL_MACHINE->Open("SYSTEM\\CurrentControlSet\\Control\\Lsa\\", $hashRef) ||  die "Open: $^E";
$hashRef->GetValues(\%vals); # get sub keys and value -hash ref

#        foreach my $k (keys %vals) {
#                $key = $vals{$k};
#                print "$$key[0] = $$key[2]\n";
#        }
                $key = $vals{$mykey};
                print "$$key[0] = $$key[2]\n";

     }
