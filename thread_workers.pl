use strict;
use warnings;
use threads;
use Data::Dumper;

my $threads;

for ( my $i = 0 ; $i <= 21 ; $i++ ) {
    $threads->[$i] = threads->new( \&twrkr, $i );
    print "\nThread ID is: " . $threads->[$i]->tid;
    
    # Use detach only when you need to just fire and forget
    #$threads->[$i]->detach;

    # Use join only when you need to wait for thread to finish
    # And capture the output
    #my $retrun_value = $threads->[$i]->join;
}

#works only when join or detach are not used
# my $count = scalar( threads->list(threads::running) );
# print("\nCurrent set of launches $count \n");


sub twrkr {
    my $name = shift;
    print "\nIn the thread " . $name;
    sleep(10);
    return $name;
}
