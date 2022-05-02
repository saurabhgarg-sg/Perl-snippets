#!/usr/local/bin/perl

#to generate the documentation of perl modules wherever available

use File::Find;
use strict;

our @pmList = qw//;

find( \&wanted, "." );
print "\n $#pmList";

foreach my $tmpFile (@pmList) {

    #my $tmpFile     =       $pmList[621]    ;
    print "\n pm: $tmpFile";
    my $htmlFile = $tmpFile;

    chop($htmlFile);
    chop($htmlFile);
    chop($htmlFile);
    $htmlFile =~ s/\\/~/g;

    print "\n html file name will be: " . $htmlFile . ".html\n";
    $htmlFile = "c:\\docum\\" . $htmlFile . ".html";
    qx/pod2html --infile=$tmpFile --outfile=$htmlFile/;
    $htmlFile = undef;
}

sub wanted {
    if (-d) {
        readPM($_);
    }
}

sub readPM {
    my ($directory) = @_;
    opendir( DIR, $directory );
    my @files = grep( /$.pm/, readdir(DIR) );
    closedir(DIR);

#        if($directory ne "."){
#                unless(-e "c:\\docum\\".$directory) {mkdir("c:\\docum\\".$directory)}       ;
#        }

    foreach my $file (@files) {
        if ( $directory ne "." ) {
            push( @pmList, $directory . "\\" . $file );
        } else {
            push( @pmList, $file );
        }
    }
}
