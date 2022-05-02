#!/usr/bin/perl

use strict; use warnings;

#print "Enter the email ID:";
#chomp($_=<STDIN>);

sub checkMail{
	local $_ = $_[0];
#	if(/\w+((\.\|\_)\w+)*\@\w+\.\w\w\w?(\.\w\w)?$/i){
	if(m!^[A-Za-z0-9]+			# match first letter(s) before any dot or underscore
	        ([._][A-Za-z0-9]+)*          # match the set of characters following ./_ 0 or more times
		\@[A-Za-z0-9]+			# match the characters following @ symbol
		\.[A-Za-z0-9][A-Za-z0-9][A-Za-z0-9]?		# match the 2/3 character string following . for domain
		(\.[A-Za-z0-9][A-Za-z0-9])?$              # match second domain if any, should be of 2 characters
		!ix){			# match case insensitive ignoring spaces
			print ("Valid due to $&\n");
		}else{
			print "Invalid \n";
	}
}

sub tester{
my @mails = qw( sgarg@novell.com
		sgarg@novell.com.in
		sgarg_sg_sg@novell.com
		sgarg@vsnl.in
		saurabh.garg.sg@gmail.com
		w@novell.com
		@novell.com
		sgarg.@novell.com
		sgarg_@novell.com
		_@novell.com
		%@novell.com
		@@novell.com
		.@novell.com
		sgarg@novell.com.in.net
		_sgarg@novell.com
		.sgarg@novell.com);

foreach my $mail (@mails){
	print "Mail sent: $mail\n\t\t\t\t -->  ";
	checkMail($mail);

	}

}

#============= main =====================#
tester();
#============= main ends =====================#
