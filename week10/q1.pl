#! /usr/bin/perl


use warnings;
use strict;

use Bio::Perl;
use Bio::Tools::Run::RemoteBlast;

#get accession number from user
print "Please enter your Accession Number:\n";
my $acc = <STDIN>;
chomp $acc;

#assumed genpept database being used
my $db = "genpept";

#get sequence
my $seq = get_sequence($db, $acc);

#build factory for blast
my $factory = Bio::Tools::Run::RemoteBlast -> new (-prog => 'blastp', -data => 'nr', -expect => '1e-10', -readmethod => 'SearchIO');

#blast sequence
$factory -> submit_blast($seq);
print "Done running first BLAST\n";


#getting results of first blast
print "Polling first BLAST\n";
while (my @rids = $factory-> each_rid){

     foreach my $rid(@rids){
          
          my $result = $factory->retrieve_blast($rid);          

          if( ref($result)){

               my $output = $result->next_result();
               my $filename = $output->query_name().".out";

               $factory->save_output($filename);
               $factory->remove_rid($rid);

               foreach my $hit($output->hits){
               
                    print "Hit Accession: ",$hit->accession,"\n";

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
 
