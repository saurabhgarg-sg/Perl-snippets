#!/usr/local/bin/perl

#@example:  ntest -hw FILER=f3050-205-31 HITS=10 bomber.thpl

use strict;
use warnings;
use Tharn;

our ( $FILER, $FILER_IP, $HITS );

param( 'FILER', '-mesg', "hostspec for filer" );
param( 'HITS',  '-mesg', "0 for singlets otherwise number of bombs" );
my $fh = host($FILER);
param( 'FILER_IP', '-default', $fh->default_ip() );

#Make conenctions
#my $fc = connect("#telnet");
my $fc = connect("#rsh");

#Global Variables to be used during the test
our @inputArray = qw//;
our $cmd        = "cifs access X testuser";
our $cmdSuffix = " "; #harmless space now we dont need to check before appending

#====================== Start of main block ====================================
for ( my $i = 0 ; $i <= 255 ; $i++ ) {
    push( @inputArray, chr($i) );
}

#print "\n".$_ foreach (@inputArray);
my @formatSpecifiers = qw/%c %d	%i %f %e %E %g %G %o %s	%u %x %X %p %n %%/;

@inputArray = ( @inputArray, @formatSpecifiers );    #size now is 271
@formatSpecifiers = undef;

$HITS ? Fuzz($HITS) : warmup();

#====================== End of main block ======================================

sub warmup {
    singlets();
    LongStrings();
}

sub singlets {

#Small function to warm up for any command and decide on the possbile output strings
    for ( my $j = 1 ; $j <= $#inputArray ; $j++ ) {
        my ( undef, undef, $output, undef ) =
          say( $fc, "$cmd \"$inputArray[$j]\" $cmdSuffix" );
        logcomment( "output is " . $output );
        $output = undef;
    }
}

sub Fuzz {
    my $hits     = shift;
    my $max      = $#inputArray + 2;
    my $strLen   = 5;
    my $patterns = qr/Invalid rights|Usage|syntax error/;

    for ( my $counter = 0 ; $counter <= $hits ; $counter++ ) {
        my $input = undef;
        for ( my $i = 0 ; $i <= $strLen ; $i++ ) {
            my $temp = $inputArray[ rand($max) ];
            $input = $input . $temp;
            $temp  = undef;
        }

        my ( undef, undef, $output, undef ) =
          say( $fc, "$cmd \"$input\" $cmdSuffix" );

        # logcomment("output is $output");
        if ( $output !~ /$patterns/ ) {
            logresult( 'WARN',
                "Did not match any of the expected outputs for input $input" );
        }
        $output = undef;
    }
}

sub LongStrings {

    #creates a string of length 4128 characters
    my $longString = "abcdefghijklmnopqrstuvwx12345678" x 129;
    my @lengths =
      qw/2 4 7 8 9 15 16 17 31 32 33 63 64 65 127 128 129 254 256 257 511 512 513 1023 1024 1025 2047 2048 2049 3071 3072 3073 4095 4096 4097/;

    foreach my $strLen (@lengths) {
        logcomment( "String length: " . $strLen );
        my $input = substr( $longString, 0, $strLen );
        my ( undef, undef, $output, undef ) =
          say( $fc, "$cmd \"$input\" $cmdSuffix" );
        $output = undef;
        $input  = undef;
    }
    $longString = undef;
}

