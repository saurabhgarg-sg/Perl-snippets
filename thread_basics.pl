use strict;
use warnings;
use threads; 

     my $thr2 = threads->new(\&sub2);
     $thr2->detach;
    
    my $thr = threads->new(\&sub1);
    my $rt = $thr->join;
    print "\nReturned value is ".$rt;
     
    sleep(9);
    sub sub1 { 
        print "In the thread\n"; 
        return 10;
    }
    
    sub sub2 { 
        print "In the thread I don't care about\n"; 
        sleep 3;
        print "\nI am still alive";
    }