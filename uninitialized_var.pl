use strict;
use warnings;

my $var;
print "\nuninitialized vairable \$var:",$var;

#Now to check if a var is defined use "defined" function of Perl

my $var1;
my $var2 = "something";

print "\nto begin with : \$var1=", defined $var1, " \$var2 = ",defined $var2;

$var1 = "junk";
$var2 = undef;

print "\nNow : \$var1=", defined $var1, " \$var2 = ",defined $var2;
