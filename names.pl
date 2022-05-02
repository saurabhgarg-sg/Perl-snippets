#!/usr/local/bin/perl

package names;

sub genLongNames{
# function to generate long names to be used for files / directories etc
# takes length to be generated as input
# returns the generated string
# also writes the string in file c:\names.txt

my ( $limit )   = @_     ;
my @small       = (a..x) ;            # 24 elements
my @caps        = (A..X) ;            # 24 elements
my @digits      = (0..9) ;            # 10 elements
my $sum         = 58     ;            # hard coded value of sum of all elements

my $remainder   = $limit % $sum                 ;
my $dividend    = ($limit-$remainder) / $sum    ;
my @finalArray ;

for (my $i = 1; $i <= $dividend ; $i++){
push(@finalArray,@small,@caps,@digits);
}

        if ($remainder >= 48){
          push(@finalArray , @small,@caps);
          $remainder    -=      48      ;
        }
        elsif($remainder >= 24 ){
          push(@finalArray , @small);
          $remainder    -=      24      ;
        }

for (my $i = 1; $i <= $remainder ; $i++){
        $finalArray[++$#finalArray] = ($i%9);
}

my $finalName = join('',@finalArray);

open (DUMPFILE,'>>',"c:\\name.txt") || die "\n\ncannot open file ".$! ;
print DUMPFILE "\n\nname length: ".length ($finalName);
print DUMPFILE "\n$finalName";
close DUMPFILE;

return ($finalName);
}

1;
