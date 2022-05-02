#!/usr/local/bin/perl
# $Id: $
#
# Copyright (c) 2005 Network Appliance, Inc.
# All Rights reserved
#
## @summary
##  Verify File Attributes After Copying To A Filer Share
##
## @description
##  Verfiy Diffenrent File Attributes After Copying the file to a filer share
##
## @param	FILER		Required: hostspec of filer.
##
## @param	CLIENT		Required: hostspec of Minwin comaptible Windows client.
##
## @param	DOMAIN		Required: hostspec of Minwin comaptible Windows client.
##
## @example	ntest -hw FILER=f270c-205-53 CLIENT=wxp205-152 DOMAIN=cifsqa3 secinfo.thpl
##
## @dependencies	none
##
## @duration
##
## @status	        new
##
## @author	        saurabhg@netapp.com
#

use strict;
use warnings;
use Tharn;
use Carp;
use TestEnv::MinWin qw(minwin_compatible);
use MapShare qw(map_cifs_share unmap_cifs_share);

our ( $FILER, $FILER_IP, $CLIENT, $DOMAIN, $SHARE );

param( 'FILER', '-mesg', "hostspec for filer" );
my $fh = host($FILER);
param( 'FILER_IP', '-default', $fh->default_ip() );
param( 'CLIENT',   '-mesg',    "hostspec for client" );
param( 'DOMAIN',   '-default', "CIFSQA3" );
param( 'SHARE',    '-mesg',    "Filer share to be used" );

#Make conenctions
my $fc = connect("#telnet");
my $ch = host($CLIENT);
my $cc = connect("#rsh");

#Global Variables to be used during the test
our $testuser  = "testuser" . time();
our $testpwd   = 'test*123';
our $testfile  = "SecurityInformationTestFile.txt";
our $sharePath = getSharePath( $SHARE, \$fc );
logcomment( "Filer path to the share is: " . $sharePath );

## Checking if client is minwin_compatible.
unless ( $CLIENT eq 'localhost' ) {
    if ( $ch->hosttype() !~ /windows/ || !minwin_compatible($CLIENT) ) {
        logresult( 'CONFIG',
                'The host '
              . $ch->hostname()
              . ' is not MinWin compatible, exiting.' );
        croak "Test aborted as client is not minwin compatible";
    }
}

#Now create the temperory user on domain that will be used for the tests
my ( undef, undef, $output, undef ) =
  say( $cc, "net user /domain /add $testuser $testpwd /active:yes" );
doCleanUp( 1, "Unable to create test user on domain, Test Aborted", \$cc )
  unless ( $output =~ "The command completed successfully." );
$output = undef;

#Using the test user created above try to map filer share given
our $shareDrive = map_cifs_share(
    server   => $FILER,
    share    => $SHARE,
    client   => $CLIENT,
    domain   => $DOMAIN,
    username => $testuser,
    password => $testpwd,
    drive    => '*'
);

doCleanUp( 1, "Failed to map filer share as test user", \$cc )
  unless ( defined($shareDrive) );

my ( undef, undef, $result, undef ) =
  say( $cc, "dir $shareDrive > $shareDrive\\$testfile" );
if ( $result =~ "Access is denied." ) {
    $result   = undef;
    $testfile = undef;
    doCleanUp( 1, "User does not seem to have write permissions on the share",
        \$cc );
}

#====================== Start of main block ====================================

SetACL( "grant", \$cc ) && VerifySetACL( "grant", \$fc );
SetACL( "edit",  \$cc ) && VerifySetACL( "edit",  \$fc );
SetACL( "deny",  \$cc ) && VerifySetACL( "deny",  \$fc );

doCleanUp( 0, "End of test", \$cc );

#====================== End of main block ======================================

sub SetACL {

    my ( $operation, $clHandle ) = @_;
    my $retVal = 1;
    my $output = undef;

    if ( $operation eq "grant" ) {
        ( undef, undef, $output, undef ) = say( $$clHandle,
            "echo Y|cacls $shareDrive\\$testfile /G $DOMAIN\\$testuser:F" );
    }
    elsif ( $operation eq "edit" ) {
        ( undef, undef, $output, undef ) = say( $$clHandle,
            "cacls $shareDrive\\$testfile /E /P $DOMAIN\\$testuser:W" );
        unless ( $output =~ /processed file:/i ) {
            logresult( 'WARN', "Unable to change Write ACEs on " . $testfile );
            $retVal = 0;
        }
    }
    elsif ( $operation eq "deny" ) {
        ( undef, undef, $output, undef ) = say( $$clHandle,
            "echo Y|cacls $shareDrive\\$testfile /D $DOMAIN\\$testuser" );
    }
    unless ( $output =~ /processed file:/i ) {
        logresult( 'WARN', "Unable to set $operation ACEs on " . $testfile );
        $retVal = 0;
    }

    if ( $output =~
        "No mapping between account names and security IDs was done" )
    {
        logcomment(
"It appears that client machine is not able to communicate to the domain."
        );
        logcomment(
"This is not a filer issue, running the cacls again sometime later may work."
        );
    }
    return $retVal;
}

sub VerifySetACL {

    my ( $ace, $flrHandle ) = @_;

    my ( undef, undef, $output, undef ) =
      say( $$flrHandle, "fsecurity show $sharePath/$testfile" );

    my @DACLs    = split( /DACL:/,    $output );
    my @fileACEs = split( /(\r|\n)+/, $DACLs[1] );
    my $fileAce  = undef;

    foreach (@fileACEs) {
        $fileAce = $_ if (/$DOMAIN\\$testuser/i);
    }

    logresult( 'PASS', "fsecurity test for ACL type $ace passed." )
      if ($output);
    logcomment( "ACE Belonging to test user is: " . $fileAce );
    if ( $ace eq "grant" ) {
        ( $fileAce =~
              m/(\s+)Allow - $DOMAIN\\$testuser - 0x001f01ff \(Full Control\)/i
          )
          ? logresult( 'PASS', "Test for Granting Rights Passed" )
          : logresult( 'FAIL', "Test for Granting Rights Failed" );
    }
    elsif ( $ace eq "edit" ) {

        ( $fileAce =~ m/Allow - $DOMAIN\\$testuser - 0x00120136/i )
          ? logresult( 'PASS', "Test for Editing Rights Passed" )
          : logresult( 'FAIL', "Test for Editing Rights Failed" );
    }
    elsif ( $ace eq "deny" ) {
        ( $fileAce =~
              m/Deny  - $DOMAIN\\$testuser - 0x001f01ff \(Full Control\)/i )
          ? logresult( 'PASS', "Test for Deny Rights Passed" )
          : logresult( 'FAIL', "Test for Deny Rights Failed" );
    }
    @DACLs  = undef;
    $output = undef;
}

sub getSharePath {
    my ( $shareName, $fhandle ) = @_;

    my ( undef, undef, $output, undef ) =
      say( $$fhandle, "cifs shares $shareName" );

    return ( ( split( /(\s)+/, ( split( /(\n)+/, $output ) )[6] ) )[2] );
}

sub doCleanUp {

    my ( $aborted, $msg, $chandle ) = @_;
    logcomment("Starting Cleanup");

    if ($testfile) {
        SetACL( "grant", \$cc );
        say( $$chandle, "del $shareDrive\\$testfile" );
    }

    say( $$chandle, "net user /domain $testuser /delete" );
    $testuser = undef;

    $shareDrive
      && unmap_cifs_share(
        drive  => $shareDrive,
        client => $CLIENT,
        force  => 1
      );

    $aborted
      ? logresult( type => 'CONFIG', abort => 1, $msg )
      : logcomment($msg);
}
