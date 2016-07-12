#! /usr/bin/perl


use strict;
use warnings;

use CGI (':standard');

my $title = 'Choose Sequence Type';
print header, start_html($title), h1($title);

if (param('submit')) {

     my $seq_type = param('seq_type');

     print p("You chose a $seq_type sequence\n", rand_seq($seq_type)), '<ul>';

     print '</ul>', hr();

}


my $url = url();
print start_form(-method => 'GET', action => $url),
     p("What type of sequence: " .radio_group(-name => 'seq_type', -values => ['protein', 'DNA'])),
     p(submit(-name=>'submit', value=>'Submit')),
     end_form(),
     end_html();

sub rand_Seq{
	
	my ($type) = (@_);
	my $len = 50;
	my $seq;

     if ($type eq 'DNA'){
	     for( my $i = 0; $i < $len; $i++){

		     $seq = $seq . rand_nucleotide();

     	}#close for
     }#close if
     elsif ($type eq 'protein') {
          for (my $k = 0; $k < $len; $k++){

               $seq = $seq . rand_amino();

          }#close for
     }#close elsif
	return $seq;


}#close rand_DNA

sub rand_nucleotide{

	my (@tide_array) = ('A', 'T', 'G', 'C');

	my $tide = $tide_array[rand @tide_array];

	return ($tide);


}#close rand_nucleotide

sub rand_amino{

	my (@amino_array) = ('G', 'A', 'V', 'L', 'I', 'P', 'F', 'Y', 'W', 'S', 'T', 'C', 'M', 'N', 'Q', 'K', 'R', 'H', 'D', 'E');

	my $amino = $amino_array[rand @amino_array];

	return ($amino);


}#close rand_amino
