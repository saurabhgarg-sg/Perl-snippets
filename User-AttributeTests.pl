#!/usr/local/bin/perl

use strict;
use warnings;

my $DEBUG = 1;

#Global values
my $testVolume   = "/vol/testAttribVol";
my $volName      = qq/testAttribVol/;
my $qtpath       = "/vol/testAttribVol/attribTests";
my $shareName    = "attribTests";
my $testFileName = "testAttrFile";
my $testDirName  = "testAttrDirectory";
my $otherDirName = "DummyAttrDirectory";
my $driveName    = $ARGV[0];
my @binCombos    = qw//;

##########################################################################
# Attribute Tests for Mixed qtree                                         #
##########################################################################
{
   print"\n drive name: $driveName"     ;
      qx{rmdir /S /Q c:\\$volName};
    BinCombinations( \@binCombos );
      my $temp = $testFileName x 21;
   qx{md c:\\$volName};
   qx{echo $temp >> c:\\$volName\\$testFileName};
   qx{md c:\\$volName\\$testDirName};
   qx{md c:\\$volName\\$otherDirName};
   qx{echo $temp >> c:\\$volName\\$otherDirName\\$testFileName};
    RunAttribTests( $driveName, $_ ) foreach (@binCombos);
}

sub RunAttribTests {
    my ( $mapped_drive, $code ) = @_;

    # if pre-existing simple clean

   print "\n inside runattr";
    #setAttrs
    SetAttributes( $code );

    #copy
#   qx{md $driveName\\$volName};

     print(
        "\n\nWaiting for user actions to be performed ...");
     <STDIN>    ;

    #check attr on copied
    print(
        "\nAttributes Found on file $driveName\\$volName\\$testFileName are:");
    DisplayAttributes(
        GetAttributes( "$driveName\\$volName\\$testFileName" ) );
    print(
        "\nAttributes Found on Directory $driveName\\$volName\\$testDirName are:"
    );
    DisplayAttributes(
        GetAttributes( "$driveName\\$volName\\$testDirName" ) );
    print(
"\nAttributes Found on file $driveName\\$volName\\$otherDirName\\$testFileName are:"
    );
    DisplayAttributes(
        GetAttributes( "$driveName\\$volName\\$otherDirName\\$testFileName"));

     print "\n now trying to delete all the files created\n";
    #delete all files created on windows & copied
#   qx{rmdir /S /Q c:\\$volName};
   qx{rmdir /S /Q $driveName\\};
}

sub SetAttributes {
    my $code  = pop;
    $DEBUG && print("\ncode recd is: $code ");

    my ( $ro, $arc, $sys, $hid ) = split( //, $code );
    print("\nTest by Setting following attributes on the file:");
    DisplayAttributes($code);
    qx{attrib -r -a -s -h c:\\$volName\\$testFileName};
    qx{attrib -r -a -s -h c:\\$volName\\$testDirName};
    qx{attrib -r -a -s -h c:\\$volName\\$otherDirName\\$testFileName};

    my $cmd = "attrib ";

    $cmd = $cmd . "+r " if ($ro);
    $cmd = $cmd . "+a " if ($arc);
    $cmd = $cmd . "+h " if ($hid);
    $cmd = $cmd . "+s " if ($sys);

    qx{$cmd c:\\$volName\\$testFileName};
    qx{$cmd c:\\$volName\\$testDirName};
    qx{$cmd c:\\$volName\\$otherDirName\\$testFileName};
}

sub GetAttributes {
    my $path  = pop;
    my $returnVal = "0000";

    my $output  = qx{attrib $path};

    my $temp = ( split( /\n/, $output ) )[-1];
    $temp =~ s/\Q$path\E//i;
    $temp =~ s/\s+//g;

    my @currAttrs = split( //, $temp );

    foreach (@currAttrs) {
        $returnVal = $returnVal | "0001" if (/[hH]/);
        $returnVal = $returnVal | "0010" if (/[sS]/);
        $returnVal = $returnVal | "0100" if (/[aA]/);
        $returnVal = $returnVal | "1000" if (/[rR]/);
    }
    return $returnVal;
}

sub DisplayAttributes {
    my $id = pop;
    my ( $ro, $arc, $sys, $hid ) = split( //, $id );
    $ro  && print("\nRead Only");
    $arc && print("\nArchive");
    $sys && print("\nSystem File");
    $hid && print("\nHidden");
}

sub BinCombinations {
    my $arrayRef = pop;

    for ( my $i = 0 ; $i <= 15 ; $i++ ) {
        my $str = unpack( "B8", pack( "v", $i ) );
        $str =~ s/^0{4}//;
        $$arrayRef[$i] = $str;
    }
}
