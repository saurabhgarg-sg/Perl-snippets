#!/usr/bin/perl

use strict;
use warnings;

our ($username, $out, @lines, $FH, $ch_no, $sDate, $eDate);

print "\nPlease Enter Unix account User Names(comma separated,ex:rajeshrv,shail,gmanish) :";
$username = <>;

print "\nPlease Enter Start Date[in yyyy/mm/dd format(ex:2010/11/01)] :";
$sDate = <>;

print "\nPlease Enter End Date[in yyyy/mm/dd format(ex:2010/11/07)] :";
$eDate = <>;

chomp($sDate);
$sDate =~ s/\s//g;
$sDate =~ s/\///g;
chomp($eDate);
$eDate =~ s/\s//g;
$eDate =~ s/\///g;

$username=~ s/\s//g;
chomp($username);
my @users;

@users = split(/,/, $username);
my $usrs = $username;
$usrs =~ s/,/_/g;
my $outFile = join ("", localtime());
$outFile = "p4_".$outFile.".log";
my $pwd = `pwd`;
print "\nGenerating the Metrics File:$outFile at $pwd\n";

open ($FH, ">$outFile");
#print $FH "UserName,Thpl_Count,PM_Count,TXI_Count\n";
print $FH "UserName,date,change#,Methods added\n";

foreach $username (@users) {
        $out = qx{p4 changes -u $username} ;
        
}
close $FH;

print "COMPLETED. \n(Please copy $outFile from $pwd to windows machine to generate graphs.)\n\n";
