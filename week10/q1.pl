#! /usr/bin/perl


use warnings;
use strict;

use Bio::Perl;
use Bio::Tools::Run::RemoteBlast;

#get accession number from user
print "Please enter your Accession Number:\n";
my $acc_1 = <STDIN>;
chomp $acc_1;

#assumed genpept database being used
my $db = "genpept";

#get 1st sequence
my $seq_1 = get_sequence($db, $acc_1);

#run blast on 1st seq
my $results_1 = run_blast ($seq_1, $acc_1);

#get next accession from 1st results
my $j = 1;
my $k = 0;
my $acc_2;

while ($j != 0){

     my $result =$results_1->[$k]->accession;

     if($result =~ /$acc_1/){

          $k = $k +1;

     }#close if
     else{

          $acc_2 = $results_1->[$k]->accession;
          $j = 0;

     }#close else
}#close while

#get 2nd sequence
my $seq_2 = get_sequence($db, $acc_2);

#run blast on 2nd sequence
my $results_2 = run_blast($seq_2, $acc_2);

#get info from 2nd results
$j = 1;
$k = 0;

while($j != 0){

     my $result = $results_2->[$k]->accession;

     if($result =~ /$acc_2/){

          $k = $k + 1;

     }#close if
     else{
     
          print "\n";

          if($result =~ /$acc_1/){

               print "Top Non-Self Accession from 2nd Search is the Accession from the 1st Search.\n"

          }#close if

               print "  Accession: $result \n";
               print "       Name: ",$results_2->[$k]->name,"\n";
               print "Description: ",$results_2->[$k]->description,"\n";
               print "     Length: ",$results_2->[$k]->length,"\n";

               $j = 0;
     }#close else

}#close while



sub run_blast {

     my ($seq, $acc) = (@_);

     #build factory for blast
     my $factory = Bio::Tools::Run::RemoteBlast -> new (-prog => 'blastp', -data => 'nr', -expect => '1e-10', -readmethod => 'SearchIO');

     #blast sequence
     print "Submitting $acc for BLAST\n";
     $factory -> submit_blast($seq);
     print "Done Running $acc BLAST\n";


     #getting results of first blast
     my @hits;
     print "Polling $acc BLAST Results\n";

     while (my @rids = $factory-> each_rid){

          foreach my $rid(@rids){
          
               my $result = $factory->retrieve_blast($rid);          

               if( ref($result)){

                    my $output = $result->next_result();
                    my $filename = $output->query_name().".out";

                    $factory->save_output($filename);
                    $factory->remove_rid($rid);

                    foreach my $hit($output->hits){
               
                         push(@hits, $hit);                    

                    }#close foreach

               }#close if
               elsif($result < 0){

                    $factory->remove_rid($rid);

               }#close elsif
               else {

                    sleep 5;
               }#close else

          }#close foreach

     }#close while

     print "Done Polling $acc BLAST Results\n";

     return \@hits;

}#close run_blast
 
