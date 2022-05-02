#!/usr/local/bin/perl

use strict;
use warnings;

#PCI\VEN_8086&DEV_10EA&SUBSYS_215317AA&REV_06\3&B1BFB68&0&C8: LAN Adapter
#PCI\VEN_8086&DEV_4239&SUBSYS_13118086&REV_35\4&36786977&0&00E1: Wireless Adapter

my $wireless =
  q{"@PCI\VEN_8086&DEV_4239&SUBSYS_13118086&REV_35\4&36786977&0&00E1"};
my $lan = q{"@PCI\VEN_8086&DEV_10EA&SUBSYS_215317AA&REV_06\3&B1BFB68&0&C8"};
my $devcon_path = 'c:\bin\devcon.exe ';

my $wirelessStatus = `$devcon_path status $wireless`;

if ( $wirelessStatus =~ "Driver is running." ) {
    `$devcon_path disable $wireless`;
    `$devcon_path enable $lan`;
} else {

    `$devcon_path enable $wireless`;
    `$devcon_path disable $lan`;
}
