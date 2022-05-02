#!/usr/local/bin/perl

package Files;

sub ReadConfFile{
            my ($confName)      =       @_      ;
		open (CONF,"< ".$confName) || die "\ncannot read the configuration file. \n$!\n\nAborting the NTLM testing.\n"      ;

		while (<CONF>) {
			chomp;                  # no newline
			s/#.*//;                # no comments
			s/^\s+//;               # no leading white
			s/\s+$//;               # no trailing white
			next unless length;     # anything left?
			my ($var, $value) = split(/\s*=\s*/, $_, 2);
			$testConf{$var} = $value;
		}
		close CONF      ;
	}

1;
