use warnings;
use strict;

#to demonstrate the use of curly braces while refering to scalars

my $this_data = "something";
my $that_data = "that data";

# invalid use:
#print "_$this_data_, or $that_datawill do \n";

print "_${this_data}_, or ${that_data}will do \n";
