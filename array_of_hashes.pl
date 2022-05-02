#!/usr/local/bin/perl

     # First lets define an array of hashes.

my @file_attachments = (
       {file => 'test1.zip',  price  => '10.00',  desc  => 'the 1st test'},
       {file => 'test2.zip',  price  => '12.00',  desc  => 'the 2nd test'},
       {file => 'test3.zip',  price  => '13.00',  desc  => 'the 3rd test'},
       {file => 'test4.zip',  price  => '14.00',  desc  => 'the 4th test'}
  );

     # Get the number of items (hashes) in the array.
my $file_no = scalar (@file_attachments);
     # $file_no is now: 4 in this instance as there is 4 hashes in the array.


     # Looping through the hash and printing out all the hash "file" elements.
for (my $i=0; $i < $file_no; $i++)
{
print '$file_attachments[$i]{'file'}  is:'. $file_attachments[$i]{'file'}."\n";
}

     # Looping through the hash and printing out all the hash "price" elements.
for (my $i=0; $i < $file_no; $i++)
{
print '$file_attachments[$i]{'price'} is:'. $file_attachments[$i]{'price'}."\n";
}

     # Looping through the hash and printing out all the hash "desc" elements.
for (my $i=0; $i < $file_no; $i++)
{
print '$file_attachments[$i]{'desc'} is:'. $file_attachments[$i]{'desc'}."\n";
}

     #The loops will return this output:

