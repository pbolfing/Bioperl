#! /usr/bin/perl

use strict;
use warnings;

use Bio::DB::RefSeq;
use Bio::Tools::Run::RemoteBlast;

#get user input
my ($search_type) = shift;
my ($seq_type) = shift;

#check user inputs
my $input_check = check_inputs($search_type, $seq_type);
while ($input_check == 0) {

     print "Search Type and Sequence Type did not match!!\n";
     print "Please Enter the Search Type: ";
     $search_type = <STDIN>;
     chomp $search_type;

     print "Please Enter the Sequence Type: ";
     $seq_type = <STDIN>;
     chomp $seq_type;

     $input_check = check_inputs($search_type, $seq_type);

}#close while

#get acc_num
print "Enter Accession Number: ";
my $acc_num = <STDIN>;
chomp $acc_num;

#get sequence
my $seq = get_sequence($acc_num);

#run blast
my $result = run_blast($seq, $acc_num, $search_type);
print $result;

#run blast
sub run_blast {

     my ($seq, $acc_num, $search_type) = (@_);

     #build factory for blast
     my $factory = Bio::Tools::Run::RemoteBlast -> new (-prog => $search_type, -data => 'nr', -expect => '1e-10', -readmethod => 'SearchIO');

     #blast sequence
     print "Submitting $acc_num for $search_type\n";
     $factory -> submit_blast($seq);
     print "$acc_num $search_type search submitted\n";


     #getting results of blast
     print "Polling $acc_num $search_type Results\n";

     while (my @rids = $factory-> each_rid){

          foreach my $rid(@rids){
          
               my $result = $factory->retrieve_blast($rid);          

               if( ref($result)){

                    my $output = $result->next_result();
                    my $filename = "$acc_num.$search_type";

                    $factory->save_output($filename);
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

     print "Done Polling $acc_num $search_type Results\n";

     return "Results Localed ./$acc_num.$search_type\n";

}#close run_blast

#get sequence
sub get_sequence{

     my ($acc_num) = @_;

     my $db = Bio::DB::RefSeq->new();
     $db->request_format('fasta');
     my $seq = $db->get_Seq_by_acc($acc_num);

     return $seq;

}#get sequence

#check user inputs
sub check_inputs {

     my ($search_type, $seq_type) = @_;
     my $x;
     my %blast_key = ( "blastn" => "dna",
                         "blastp" => "protein",
                         "blastx" => "dna",
                         "tblastx" => "dna",
                         "tblastn" => "protein");     
     
     if ($blast_key{$search_type} eq $seq_type){

          $x = 1;

     }#close if
     else {
       
          $x = 0;

     }#close if

     return $x;

}#close check_inputs
