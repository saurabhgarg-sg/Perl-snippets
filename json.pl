#!/usr/bin/perl 

use strict;
use warnings;

use JSON;
use Data::Dumper;

my %data = (1 => 'val1',
            2 => 'val2',
            3 => 'val3',
           );
my $json_text = to_json(\%data);
print "\n JSON Text is :\n";
print $json_text;

print "\n\nWhen this is converted back to string we get:";
my $var = from_json($json_text);
print (Dumper($var));

print "\n";
