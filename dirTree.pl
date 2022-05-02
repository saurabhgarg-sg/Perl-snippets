#!/usr/bin/perl

use strict;use warnings;

our $tab;
print "Enter the directory path: ";
chomp(my $input=<STDIN>);

local $\="\n";local $,="\t";
local $tab=0;

getTree($input);

sub getTree{
	opendir DIR,"$_[0]" || die "cannot open the directory";
	my @files= readdir(DIR);
	closedir DIR;

	print ("\n".("\t"x($tab++))."Directory: $_[0]") if($tab==0); 

	foreach my $name (@files){
	    if($name !~ /\.[\.]?/){
		if(-d $_[0]."/".$name){
			print ("\n".("\t"x($tab++))."Directory: $name");
			    getTree($_[0]."/".$name);
			$tab--;
			}else{
				print ("\t"x($tab)." file: $name");
			}
		    }
		}
	}  # EOF getTree
