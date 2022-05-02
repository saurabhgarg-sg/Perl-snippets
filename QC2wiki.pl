#!/usr/local/bin/perl

use strict;
use warnings;

use Spreadsheet::Read;
use Data::Dumper;

usage() if ( ( $#ARGV + 1 ) != 5 );

my $filepath    = $ARGV[0];
my $sheetNumber = $ARGV[1];
my $startRow    = $ARGV[2];
my $endRow      = $ARGV[3];
my $outFile     = $ARGV[4];

my $xls = ReadData($filepath);

my $index   = $startRow;
my @columns = qw{C D E F O P};

open( CASES, "> $outFile" ) || croak("Cannot open the output file for writing");

#Start with table headers
print CASES qq[{| cellpadding="5" border="1"];
print CASES "\n";
print CASES qq[|+ <font size="+2">'''Detailed Test Cases'''</font>];
print CASES "\n";
print CASES "\n!Test Requirement ID";
print CASES "\n!Test  Name";
print CASES "\n!Assertion Test";
print CASES "\n!Execution Priority";
print CASES "\n!Test Procedure";
print CASES "\n!Expected Result";
print CASES "\n";

while ( $index <= $endRow ) {
    print CASES "\n|-";
    print CASES "\n|" . $xls->[$sheetNumber]{ $columns[0] . $index };
    print CASES "\n|" . $xls->[$sheetNumber]{ $columns[1] . $index };
    print CASES "\n|" . $xls->[$sheetNumber]{ $columns[2] . $index };
    print CASES "\n|" . $xls->[$sheetNumber]{ $columns[3] . $index };

    my $procedure = $xls->[$sheetNumber]{ $columns[4] . $index };
    $procedure =~ s/([\d]+.)/\n$1/g;
    print CASES "\n|" . $procedure;
    $procedure = undef;

    print CASES "\n|" . $xls->[$sheetNumber]{ $columns[5] . $index };
    print CASES "\n";

    $index++;
}

print CASES "\n";
print CASES qq[|}];
close(CASES);

sub usage {
    print "\nInvalid number of arguments passed !!!\n";
    print "\n usage: ";
    print
"\n perl QC2wiki <excel path> <Sheet Number> <Start Row Number> <End Row Number> <Cases File Name>";
    exit;
}
