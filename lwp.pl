#!/usr/local/bin/perl -w

use strict;
use warnings;
use LWP;

#use HTML::TreeBuilder;
#use HTML::TokeParser;
#use HTML::TableContentParser;
use Data::Dumper;

# Fetch the data using username
my $agent = LWP::UserAgent->new();
my $url   = q{
  http://cedprod.corp.netapp.com:10080/search?index=3&userName=saurabhg};

my $response = $agent->request( HTTP::Request->new( POST => $url ) );
die "Unable to fetch any data \nError: " . $response->status_line()
  unless ( $response->is_success() );
my $cntnt = $response->content();

#print $cntnt ;
# Now parse the HTML content
#my $p = HTML::TableContentParser->new();
#my $tables = $p->parse($cntnt);

#for my $t (@$tables) {
#    for my $r (@{$t->{rows}}) {
#            print "Row: ";
#      for my $c (@{$r->{cells}}) {
#        print "[$c->{data}] ";
#      }
#      print "\n";
#    }
#  }

# Now parse the HTML content
_parser($cntnt);

sub _parser {
    my $content = shift;
    local $\ = "\n";

    my @tags = (
        "Name:",         "Title:",
        "UserName:",     "Mail Server:",
        "Office:",       "Location:",
        "Local Time:",   "SME:",
        "Address:",      "E-Mail:",
        "Direct Phone:", "Main Phone:",
        "Mobile Phone:", "Company - Cost Center:",
        "Type:",         "HR ID:"
    );

    my @lines = split( /\n/, $content );
    my $i = 0;

    foreach my $line (@lines) {
        if ( $line =~ /\>$tags[$i]\</ ) {
            print "Orignial " . $line;
             ( $i < $#tags )? $i++:last;
        }
    }

    #remove blank lines
    #$temp =~ s/^\s+//g;
    #remove comments
    #$temp =~ s/\<!--.*-->//sg;
    #remove javascripts
    #$temp =~ s/\<script.*?\<\/script>//sg;
    #$temp =~ s/(\n|\t|&nbsp;)//g;
    #$temp =~ s/\<[^\<]+\>//g;

    # my @blocks = split( /class="boxheader">/, $content );

#print scalar(@blocks) ;
#print "New Block starting ############################### \n".$_ foreach (@blocks);
#print $temp ;
#print "New Block starting ############################### \n". $blocks[1];
#print "New Block starting ############################### \n". $blocks[2];
#print "New Block starting ############################### \n". $blocks[3];

    #parse personal details
    #print "Block is: ".$blocks[1];
    #    my $temp = $blocks[1];
    #    $temp =~ s/\s{2,}//g;

#  #print $temp;
#  #my @pdetails = split(/class="text12">|class="text12" valign = "top">/,$temp);
#    my @pdetails = split( /<[^<]+>/, $temp );
#    my $i = 0;
#    foreach (@pdetails) {

    #        #s/<[^<]+>//sg;
    #        print $i. " " . $_;
    #        $i++;
    #    }

}
