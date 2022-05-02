#!/usr/local/bin/perl

my $name=2;
for($name=2;$name<=291;$name++){
system("rsh 10.72.205.31 -l root cifs shares -delete -f $name");
}

