#!/usr/local/bin/perl
use strict;
    use warnings;
print "\nEnter the string: ";
    my $char = <STDIN>;    # A smiley face
    chomp($char);

    # Put 'use bytes' in a closure so that it doesn't
    # affect the rest of the program.  (The 'use bytes' pragma
    # disables character semantics for the rest of the lexical
    # scope in which it appears).

    {

        use bytes;

        my $byte_size = length($char);

        print "Bytes: $byte_size\n";

    }

    # Character size here
    my $size = length($char);

    print "Chars: $size\n";

    exit 0;
