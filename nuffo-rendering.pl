#!/usr/local/bin/perl

use strict;
use warnings;

my $nuffoPath =
'/x/eng/http/html/engineering/projects/releases/patches/status/7.3.1.1/Protocols/cifs';
print $nuffoPath;

SetPermissions( $nuffoPath, 0 );

sub SetPermissions {
    my ( $location, $level ) = @_;
    opendir( DIR, $location )
      || die "Cannot open the specified location " . $location;

    $level++;
    my @contents = readdir(DIR);

    foreach my $element (@contents) {
        my $path = $location . "/" . $element;
        if ( ( -d $path ) && ( $element !~ /(^\.\.?)/ ) ) {
            my $output = qx{chmod -cf 777 $path};

            print "\n";
            my $tab = "   |" x $level;
            ($?)
              ? print "\n" . $tab . "--" . $element
              : print "\n" . $tab . "--" . $element . "  <--- CHANGED";

            SetPermissions( $path, $level );
        }
    }
}
