#!/usr/bin/perl 

use strict;
use warnings;
    
use LWP::UserAgent;
use JSON;
 
my $ua = LWP::UserAgent->new;
#$ua->timeout(10);

my $req = HTTP::Request->new(GET => 'http://localhost:4000/treeBuilderImages/docNodeLastFirst.gif');
#  my $req = HTTP::Request->new(GET => 'http://localhost:4000/cdmi_capabilities/');
  $req->header('Accept' => 'application/cdmi-capability'); 
  #$req->header('Accept' => 'application/cdmi-capability'); 

 my $response = $ua->request($req);
 if ($response->is_success) {
     print $response->decoded_content;  # or whatever
 }
 else {
     die $response->status_line;
 }	