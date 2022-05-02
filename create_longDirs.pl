#!/usr/local/bin/perl

use File::Path;

my @random_Name = (a..z);
push(@random_Name,(A..Z));
push(@random_Name,(a..z));
push(@random_Name,(A..Z));

my @finalName = @random_Name;

for(my $i=1;$i<=15;$i++){
push(@finalName,"/",@random_Name);
}

my $finalpath = join('',@finalName);

print $finalpath;

eval { mkpath($finalpath) };
  if ($@) {
    print "Couldn't create $dir: $@";
  }
