#!/usr/bin/perl 

use strict;
use warnings;
    
require LWP::UserAgent;
 
my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;
 
my $response = $ua->get('http://10.73.142.1:4000/');
 
 if ($response->is_success) {
     print $response->decoded_content;  # or whatever
 }
 else {
     die $response->status_line;
 }	