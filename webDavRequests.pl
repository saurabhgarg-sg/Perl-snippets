#!/usr/local/bin/perl

#perl script to fill the filer with webdav requests
#for(my $i=0;$i<=1000;$i++){
while(1){
sleep(1);
    webDavReqs($i);
}

sub webDavReqs{
 my $counter = pop ;
 use HTTP::DAV;
 open (LOGFILE,">> webDavReqs.log")|| warn "\n unable to create a log file\n$!"        ;

   $d = new HTTP::DAV;
   $url = "http://10.72.205.53/ntlm/";

   $d->credentials( -user=>"cifsqa3\\administrator",-pass =>"cifs*123", -url =>$url );

   #$d->open( -url=>$url )  or print LOGFILE "\nCouldn't open $url: " .$d->message . "\n";
   $d->open( -url=>$url )  ;
   # Make a new directory
  # my $newdir = "newdir".$counter;
  my $newdir = "newdir".time();
   $d->mkcol( -url => "$url/$newdir" );
#      or print LOGFILE "\nCouldn't make newdir at $url\n";
     close(LOGFILE)    ;
}
