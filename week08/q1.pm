package RestrictionEnzyme;

use Moose;


#set attributes of enzyme
#only recognition sequence required at this time
has name => (is => 'rw', );
has manufacturer => (is => 'rw',);
has rec_seq => (is => 'rw', required => 1);


#method to apply rec_seq to DNA 
sub cut_dna {


     my $self = shift;
     my $in_dna = shift;
     my $rec_seq = $self-> rec_seq;
     my $out_dna;
     my @frags;
     my $insert;


     if ($in_dna =~ m/$rec_seq/){

          $out_dna = $in_dna;
     
          while($out_dna =~ m/$rec_seq/){

               if ($out_dna =~ s/(.*)($rec_seq)(.*)/$1/){

                    $insert = $3; 
               
                    if ($insert =~ /\S+/){
                                      
                         unshift (@frags, $insert);

                    }#close if
               }#close if

          }#close while

          unshift (@frags, $out_dna);

          return @frags;

     }#close if
     else {

          return "The DNA did not contain the Restriction Site of the Enzyme.\n";

     }#close else



}#close cut_dna


1;
