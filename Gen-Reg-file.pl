use strict;
use Tharn;

use vars('$FILER','$FILER_IP', '$CLIENT', '$DOMAIN', '$PASSWD', '$USER', '$SHARE', '$LISTTESTCASES');

param('FILER', '-mesg', "hostspec for filer");
my $fh = host($FILER);
param('FILER_IP','-default', $fh->default_ip());
param('CLIENT', '-mesg', "hostspec for client");
param('DOMAIN', '-default', "CIFSQA3");
param('USER', '-default', "Administrator");
param('PASSWD', '-default', "cifs*123");

#Make conenctions
my $fh = host($FILER);
my $fc = connect("#rsh");

my $ch = host($CLIENT);
my $cc = connect("#rsh");

my $cc_ref = \$cc       ;

regCreate($cc_ref,4)      ;

sub regCreate{
 my ($handle,$clm)   =       @_      ;
 
 my $content    =       "REGEDIT4"      ;
 say($$handle,'echo '.$content.' > c:\test.reg')        ;
 say($$handle,'echo. >> c:\test.reg')        ;
 say($$handle,'echo. >> c:\test.reg')        ;
 $content       =   q{[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\]}       ;
 say($$handle,'echo '.$content.' >> c:\test.reg')        ;
 $content       =        q{"lmcompatibilitylevel"=dword:0000000}.$clm;
 say($$handle,'echo '.$content.' >> c:\test.reg')        ;
}


