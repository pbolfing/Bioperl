package RestrictionEnzyme;

use Moose;


#set attributes of enzyme
#only recognition sequence required at this time
has name => (is => 'rw', );
has manufacturer => (is => 'rw',);
has rec_seq => (is => 'rw', required => 1);


#method to apply rec_seq to DNA 
=item cut_dna("input sequence")
takes an DNA sequence as an input and applies the restriction enzyme to it
returns an array of the fragments
=cut

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

=head1 RestrictionEnzyme

This module is written to hold the RestrictionEnzyme object in the name, manufacturer and rec_seq attributes. It also contains a cut_dna method that applies the restriction enzyme to a given DNA sequence and returns an array of the fragments

=cut
