#! /usr/bin/perl

use strict;
use warnings;

use Storable;

my @data = ();

for ( my $j = 0; $j <10; $j++) {

     $data[$j] = (rand_DNA(50));

}#close for loop

store \@data, 'file';

sub rand_DNA{
	
	my ($len) = (@_);
	my $dna_len;
	my $dna;

	$dna_len = $len;

	for( my $i = 0; $i < $dna_len; $i++){

		$dna = $dna . rand_nucleotide();

	}#close for

	return "$dna";


}#close rand_DNA


sub rand_nucleotide{

	my (@tide_array) = ('A', 'T', 'G', 'C');

	my $tide = $tide_array[rand @tide_array];

	return ($tide);


}#close rand_nucleotide
