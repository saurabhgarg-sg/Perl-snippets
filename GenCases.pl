#!/usr/local/bin/perl

use strict;
use warnings;

use Spreadsheet::Read;
use Data::Dumper;

usage() if ( ( $#ARGV + 1 ) != 5 );

my $filepath    = $ARGV[0];
my $sheetNumber = $ARGV[1];
my $startColumn = $ARGV[2];
my $endColumn   = $ARGV[3];
my $outFile     = $ARGV[4];

my %testCases;
my $xls = ReadData($filepath);

my $index   = $startColumn;
my $counter = 0;

while ( $index <= $endColumn ) {
    my $Cclmn = "C" . $index;
    my $Dclmn = "D" . $index;

    $testCases{ $xls->[$sheetNumber]{$Cclmn} } = $xls->[$sheetNumber]{$Dclmn};
    $index++;
    $counter++;
}

print "\nFound $counter test cases\n";

#Code to generate Cases File
my $tcname = undef;

open( CASES, "> $outFile" );

foreach $tcname ( keys %testCases ) {
    print CASES "\nBegin Case";
    print CASES "\n\t Name: $tcname";
    print CASES "\n\t Description: $testCases{$tcname}";
    print CASES "\n\t Automation: Not Planned";
    print CASES "\n\t AutoScript: None";
    print CASES "\nEnd Case\n";
}

sub usage {
    print "\nInvalid number of arguments passed !!!\n";
    print "\n usage: ";
    print
"\n perl gencases <excel path> <Sheet Number> <Start Row Number> <End Row Number> <Cases File Name>";
    print "\n Script will run hardcoded columns C & D\n";
    exit;
}
