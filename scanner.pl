#!/usr/local/bin/perl
use strict;
use warnings;

unshift(@INC, "/u/saurabhg/tools/perl_modules") || die "\nunshift failed : $!"; # Prepend a directory name
require 'Net/SSH.pm';
import SSH;

my $host = "siml1.eng.btc.netapp.in"    ;
my $user = "saurabhg"           ;
my $cmd = "eval 'hostname;users|wc -w' >> ~/tmp/scanner.log"  ;

qx{ date > ~/tmp/scanner.log };

for(my $i = 1 ; $i<=28 ; $i++){
  $host = "siml".$i.".eng.btc.netapp.in"    ;
  print "connecting to $host  ..."     ;

 if (!defined(my $kidpid = fork())) {
    # fork returned undef, so failed
    die "Cannot fork: $!";
    } elsif ($kidpid == 0) {
        # fork returned 0, so this branch is child
        Net::SSH::ssh_cmd("$user\@$host",$cmd);
  }
  sleep(3);
 }
