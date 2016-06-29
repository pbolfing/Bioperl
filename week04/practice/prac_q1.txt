#!  /usr/bin/perl

use strict;
use warnings;

#create arrays
my @array1 = ( "I" , "hope", "that");
my @array2 = ( "I", "am", "doing");
my @array3 = ( "this", "right", "!");

#create hash of arrays
my %hoa = ( one => \@array1, two => \@array2, three => \@array3);

#create ref to hoa
my $hoa_ref = \%hoa;


#read each key and print
foreach (keys %$hoa_ref){

	print "$_ --> ";
	

	#read array for a key and print 
	foreach (@{$hoa_ref->{$_}}){

		print "$_ ";		

	}
	
	print "\n";

}
