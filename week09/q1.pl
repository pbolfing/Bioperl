#! /usr/bin/perl


use warnings;
use strict;
use List::MoreUtils qw(firstidx);

use Bio::Perl;

#get file name
print "Please enter file name: \n";
my $file = <STDIN>;
chomp $file;

#read file
my @bio_seq_objects = read_all_sequences("./$file", 'fasta');

#array to hold seq names for searching
my @names;

#store sequence information
foreach my $seq( @bio_seq_objects ) {

     my $name = $seq->display_id;
     my $accession = $seq->accession_number;
     my $sequence = $seq->seq;

     push(@names, $name);     

     #print sequence information
     print "
Name: $name
 ACC: $accession

";

}

#Number of sequences to be blast
print "How many sequences to you wish to Blast?\n";
my $num_seq = <STDIN>;

#get sequence names for Blast
print "Enter Name of sequence you wish to Blast: \n";
my @seq_names;
for(1 .. $num_seq){
     
     my $seq_name = <STDIN>;
     chomp $seq_name;
     push @seq_names, $seq_name;
}

#Blast each sequence and store result in individual files
for (my $i = 0; $i<$num_seq; $i++){

     my $index = find_index ($seq_names[$i], @names);

     if($index == -1){

          print "Sorry, you entered an invalid Sequence Name";

     }#close if
     else{
          my $blast_results = run_blast($index, @bio_seq_objects);

          my $out_file = "./$seq_names[$i].blast";
          write_blast(">$out_file", $blast_results);
     
     }#close else
     
}#close for

#finds array index for given sequence name
sub find_index {

     my ($seq_id, @names) = (@_);
     
     my $index = firstidx{$_ eq $seq_id} @names;

     return $index;

}#close find_index

#run blast
sub run_blast{

     my ($index, @objects) = (@_);
     my $blast;
     my $seq;

     #if fasta is for DNA translate to protein
     if ($objects[$index]->seq =~ /[^ATGC]/){

          $seq = $objects[$index]->translate();

     }#close if
     else{
          $seq = $objects[$index]->seq;
     }#else

     $blast = blast_sequence($seq) or die("can't blast this sequence");

     return $blast;
}#run_blast


