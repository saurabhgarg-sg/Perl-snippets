#!/usr/local/bin/perl

use strict;
use warnings;

usage() if ( ( $#ARGV + 1 ) != 4 );
my $caseFilePath    = $ARGV[0];

open( CASES, $caseFilePath )
  || die "Cannot open the cases file " . $caseFilePath . "\n" . $!;

my $resultFileName = ( split( /.cases/, $caseFilePath ) )[0] . '.results';

open( RESULTS, ">", $resultFileName )
  || die "Cannot Create Results file " . $resultFileName . "\n" . $!;

my $line = undef;

while ( defined( $line = <CASES> ) ) {
    if ( $line =~ /Name:/i ) {
        print RESULTS ("\nBegin Result");
        my $temp = ( split( /Name:/, $line ) )[1];
        chomp($temp);
        print RESULTS ( "\n\tCase:" . $temp );
        print RESULTS ("\n\tDate: " . $ARGV[1] );
        print RESULTS ("\n\tTester: saurabhg");
        print RESULTS ("\n\tStatus: PASS");
        print RESULTS ( "\n\tRelease: " . $ARGV[2] );
        print RESULTS ( "\n\tlogfile: " . $ARGV[3] );
        print RESULTS ("\nEnd Result\n");
    }
}

close(CASES);
close(RESULTS);

sub usage {
    print "\nInvalid number of arguments passed !!!\n";
    print "\n usage: ";
    print "\n perl gen-results <Cases File Name> <date> <release> <log Directory>\n\n";
    exit;
}
