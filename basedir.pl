#!/usr/bin/perl
# program to extract the basedirectory of a file
use File::Spec;
use File::Basename;

use strict;
use warnings;

#============= main =====================#
print "Enter the file name: ";
my $input=<STDIN>;
chomp($input);

(my $volumes, my $path, my $file)= File::Spec->splitpath($input);

local $\="\n";
print "canonpath: ". File::Spec->splitpath($input);

print "volume: $volumes";
print "path: $path";
print "file: $file";

my($filename,$directory,$suffix) = fileparse($input);
print ("Filename via basename module: $filename");
print ("Directory via basename module: $directory");
#============= main ends =====================#
