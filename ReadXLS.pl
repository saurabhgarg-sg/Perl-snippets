#!/usr/local/bin/perl

use strict;
use warnings;

use Spreadsheet::Read;
#use Spreasheet::ParseExcel;
use Data::Dumper;

my $xls = ReadData ("C:\\Documents and Settings\\saurabhg\\My Documents\\Valuate\\sample.xls");

print $xls->[1]{C6};
print "\t".$xls->[1]{D6};


#code to generate cases file


sub usage{

print "\n usage: \n";
print "\n \t perl gencases <excel path> <Sheet Number> <start column> <end column> ";
}
