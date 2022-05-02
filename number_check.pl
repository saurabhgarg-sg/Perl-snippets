use strict;
use warnings;

my $reply = 'anything' ;

while (($reply ne 'q')&($reply ne 'Q')){

print "\nEnter the variable (q to quit): ";
$reply=<STDIN>;
chomp($reply);

# regex to match proper numbers including integer/ float

if ($reply =~ m/^[-+]?(([0-9]*(.[0-9]+)?)|[0-9]+)$/){
	print "A valid Number \n";
}
else{	
	print "Invalid Number\n";
	}
}