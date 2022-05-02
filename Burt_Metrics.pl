#!/usr/bin/perl -w

use strict;

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
$outFile = "Burt_Metrics_".$outFile.".csv";
my $pwd = `pwd`;
print "\nGenerating the Metrics File:$outFile at $pwd\n";

open ($FH, ">$outFile");
print $FH "UserName,Thpl_Count,PM_Count,TXI_Count\n";

foreach $username (@users) {

        #$out = `p4 changes -u $username  | cut -d ' ' -f2,4,6`;
        $out = `p4 changes -u $username | cut -d ' ' -f2,4,6 | sed 's/@.*//'`;
        @lines = split (/\n/, $out);

        my ($out1, $burtLine, @affFiles, @temp, $date, %files, $thpl, $pm, $txi);
        $#affFiles = -1;
        $thpl = 0;
        $pm = 0;
        $txi = 0;
        foreach my $line (@lines) {
            $#affFiles = -1;
	    $line =~ s/\s/,/g;
            ($ch_no) = $line =~ /^(\d+),.*/;
            ($date)=$line=~/^\d+,(.*?),[^\d]*?/;
            $date =~ s/\s//g;
            $date =~ s/\///g;
            if ($date >= $sDate && $date <= $eDate) { 

                $out1 = `p4 describe $ch_no`;
                $out1=~s/Differences.*$//;
                ($burtLine) = ($out1 =~ /.*?burt(\d+).*/); 
                @temp = split(/\n/, $out1); 
                foreach my $ln (@temp) { 
                     if ($ln =~ /(edit|add)$/) {
                         $ln =~ s/(edit|add)$//; 
                         $ln =~ s/\.*//; 
                         $ln =~ s/#\d+//; 
                         $affFiles[$#affFiles+1] = $ln; 
                     }
                 }
                 foreach (@affFiles) {
                     if ( $_ =~ /\.thpl/i) {
                         $thpl++;
                     }
                     if ( $_ =~ /\.pm/i) {
                         $pm++;
                     }
                     if ( $_ =~ /\.txi/i) {
                         $txi++;
                     }
                 }

             }
        }
        print $FH "$username,$thpl,$pm,$txi\n";
}
close $FH;

print "COMPLETED. \n(Please copy $outFile from $pwd to windows machine to generate graphs.)\n\n";
