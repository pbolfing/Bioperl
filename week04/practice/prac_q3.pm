
package prac_q3;

	use strict;
	use warnings;


	use Exporter 'import';
	our @EXPORT_OK = ("rand_DNA");


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

		return "$dna";


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





=pod


This method works by calling the rand_DNA() fucntion
rand_DNA() can take two arguments, with first being required and second being optional
The first argument determines the maximum sequence length
the second argument determines if provided will cause rand_DNA() to produce a random sequence length
that is between the 1 and the max value entered as the first argument

Exmample use

	Only one argument
	rand_DNA(75);

	Two arguments
	rand_DNA (75, 1);
	rand_DNA (75, "option");

	It should be noted that the second argument can be any string, character or number as rand_DNA 
	simply looks for the presence of a second argument and not its value


=cut
