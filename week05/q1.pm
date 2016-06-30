
package q1;

	use strict;
	use warnings;

	use Exporter 'import';
	our @EXPORT_OK = ("prod");

	sub prod {

		#create arrays
		my @array1 = (1,2,3 );
		my @array2 = (2,4,6);

		#create array  of arrays
		my @aoa = ( \@array1, \@array2);

		#create ref to hoa
		my $aoa_ref = \@aoa;

		return $aoa_ref;
	}


# use it

1;
