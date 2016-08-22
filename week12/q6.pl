#! /usr/bin/perl

use strict;
use warnings;

use Bio::Perl;
use Bio::SeqIO;
use Bio::Tools::Run::RemoteBlast;


#get accession number
print "Please Enter Your Accession Number: ";
my $acc_num = <STDIN>;
chomp $acc_num;

#get seq
my $seq = get_seq($acc_num);

#get e-value
print "Please Enter e-value: ";
my $e_value = <STDIN>;
chomp $e_value;

#run blast
my $results = run_blast($seq, $acc_num, $e_value);


#save results
my $y = save_results($results, $acc_num, $e_value);
print $y;

#save results
sub save_results {

     my ($results, $acc_num, $e_value) = @_;
     my @array_results = @{$results};
     my $x;


     if (scalar(@array_results) == 0){

          $x = "No results found for $acc_num with an e-value of $e_value\n";

     }#close if
     else{

          foreach my $result(@array_results){
               
               #get result seq using accession number
               my $result_acc = $result->accession;
               my $seq = get_seq($result_acc);

               #write seq to new file
               my $out = Bio::SeqIO->new(-file => ">$result_acc", -format => 'fasta'); 
               $out->write_seq($seq);              

          }#close foreach
          $x = "Results are located ./<result_accession>\n";

     }#close else

     return $x;

}#close save_results

#run blast
sub run_blast {

     my ($seq, $acc_num, $e_value) = (@_);

     #build factory for blast
     my $factory = Bio::Tools::Run::RemoteBlast -> new (-prog => 'blastp', -data => 'nr', -expect => $e_value, -readmethod => 'SearchIO');

     #blast sequence
     print "Submitting $acc_num for blastp\n";
     $factory -> submit_blast($seq);
     print "$acc_num blastp search submitted\n";


     #getting results of blast
     print "Polling $acc_num blastp Results\n";

     my @hits;
     my $hit_num;

     while (my @rids = $factory-> each_rid){

          #print "In while, before foreach: ",scalar(@rids),"\n";

          foreach my $rid(@rids){
          
               my $result = $factory->retrieve_blast($rid);          

               if( ref($result)){

                    my $output = $result->next_result();
                    #my $filename = $acc_num.blast;

                    foreach my $hit($output->hits){
               
                         push(@hits, $hit);                    

                    }#close foreach
                         
                    #$factory->save_output($filename);
                    $factory->remove_rid($rid);

               }#close if
               elsif($result < 0){

                    $factory->remove_rid($rid);

               }#close elsif
               else {

                    sleep 5;
               }#close else

          }#close foreach

     }#close while

     #print "Outside while: ", scalar(@rids), "\n";

     print "Done Polling $acc_num blastp Results\n";

     return \@hits;

}#close run_blast

#get sequence
sub get_seq{

     my ($acc_num) = @_;

     my $seq = get_sequence('GenBank', $acc_num);

     return $seq;

}#get sequence
