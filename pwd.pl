#!/usr/bin/perl

use strict;
use warnings;

# Program to implement the new password policy :-)
#============================= main ===============================
my $input = -1;
print "\nEnter the site name: ";
my $sitename = <STDIN>;
chomp($sitename);
$sitename = lc($sitename);

while ( $input == -1 ) {
    print "\nEnter the required level: ";
    my $level = <STDIN>;
    chomp($level);

    $input = 1;
    if ( $level == 1 ) {
        longjump($sitename);
    }
    elsif ( $level == 2 ) {
        shortjump($sitename);
    }
    elsif ( $level == 3 ) {
        jump($sitename);
    }
    else {
        print "\nInvalid input !\n";
        $input = -1;
    }
}

print "\n\nEnter any key to continue ...";
<STDIN>;

#========================= main ======================================

sub longjump {

    #three inputs username, site & salt
    my ($sitename) = @_;
    my %numcodes = (
        a => "1",
        b => "2",
        c => "3",
        d => "4",
        e => "5",
        f => "6",
        g => "7",
        h => "8",
        i => "9",
        j => "1",
        k => "2",
        l => "3",
        m => "4",
        n => "5",
        o => "6",
        p => "7",
        q => "8",
        r => "9",
        s => "0",
        t => "2",
        u => "3",
        v => "4",
        w => "5",
        x => "6",
        y => "7",
        z => "8",
    );

    print "\nEnter the username: ";
    my $username = <STDIN>;
    chomp($username);
    my @uname = split( '', $username );
    ( $uname[0], $uname[2] ) = ( $uname[2], $uname[0] );
    $username = join( '', @uname );

    print "\nEnter the salt: ";
    my $salt = <STDIN>;
    chomp($salt);
    $salt = lc($salt);

    my $number =
        $numcodes{ substr( $sitename, 0, 1 ) }
      . $numcodes{ substr( $sitename, 1, 1 ) }
      . $numcodes{ substr( $sitename, 2, 1 ) };
    my $remainder = $number % 3;

    if ( $remainder != 0 ) {
        $number = $number + ( 3 - $remainder );
    }
    my @tempar = split( '', $salt );
    ( $tempar[0], $tempar[2] ) = ( $tempar[2], $tempar[0] );
    ( $tempar[ $#tempar - 2 ], $tempar[ $#tempar - 1 ] ) =
      ( $tempar[ $#tempar - 1 ], $tempar[ $#tempar - 2 ] );
    ( $tempar[ $#tempar - 1 ], $tempar[$#tempar] ) =
      ( $tempar[$#tempar], $tempar[ $#tempar - 1 ] );
    $tempar[0] = uc( $tempar[0] );
    $tempar[1] = uc( $tempar[1] );
    $tempar[2] = uc( $tempar[2] );

    my $newsalt = join( '', @tempar );
    my $password = $username . "~" . $number . "^" . $newsalt;
    print "\n\n\t\t$password";
}

sub jump {
    print "\n\n\tkool-" . uc( $_[0] ) . "-120";
}

sub shortjump {

    #for little easier things :-)
    my ($sitename) = @_;

    print "\nEnter the site type: ";
    my $type = <STDIN>;
    chomp($type);

    print "\n\n\t" . lc($type) . '_270$' . uc($sitename);
}
