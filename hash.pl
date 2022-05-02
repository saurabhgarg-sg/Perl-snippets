use strict;
use warnings;

my %table = qw/ram laxman krishan radha jai veeru/ ;
my @lastnames = values %table;
my @firstnames = keys %table;

print "\n firstnames: ";
foreach my $element (@firstnames){
        print "$element  ";
}

print "\n Lastnames: ";
foreach my $element (@lastnames){
        print "$element  ";
}
print "\n\n"    ;
{
local $,="\n";

print %table    ;
}
