#! /usr/bin/perl

use strict;
use warnings;


print rand_DNA(25,"option");


sub rand_DNA{
	
	my ($len, $option_arg) = (@_);
	my $dna_len;
	my $dna;

	if ($option_arg){

		$dna_len = rand_len($len);
		
	}#close if
	else {

		$dna_len = $len;

	}

	for( my $i = 0; $i < $dna_len; $i++){

		$dna = $dna . rand_nucleotide();

	}#close for

	return "$dna\n";


}#close rand_DNA


sub rand_len{

	my ($x) = (@_);

	return (int( rand($x))+1);

}#close rand_len


sub rand_nucleotide{

	my (@tide_array) = ('A', 'T', 'G', 'C');

	my $tide = $tide_array[rand @tide_array];

	return ($tide);


}#close rand_nucleotide
