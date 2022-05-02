print "enter a number: ";
chomp ($n=<STDIN>);

$,="\t";$\="\n";

print eval (join("+",split(//,$n)));

