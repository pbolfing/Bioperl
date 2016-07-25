package RestrictionEnzyme;


#set attributes of enzyme
#only recognition sequence required at this time
sub new {

	my ($class, %attribs) = (@_);
	my $obj = {
		_name => $attribs{name}	|| 'unknown',
		_manu => $attribs{manufacturer} || 'unknown',
		_rec_seq => $attribs{rec_seq} || die( "need recognitionsequence" ),
	};#close $obj

	return bless $obj, $class;
}#close new


#method to apply rec_seq to DNA 
=item cut_dna("input sequence")
takes an DNA sequence as an input and applies the restriction enzyme to it
returns an array of the fragments
=cut

sub cut_dna {


     my $self = shift;
     my $in_dna = shift;
     my $rec_seq = $self-> {_rec_seq};
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

#accessor for name
sub get_name {

	my($self) = (@_);
	return $self->{_name};

}#close get_name

#mutator for name
sub set_name{

	my($self, $new_name) = (@_);
	$self->{_name} = $new_name;
	return $self->{_name};

}#close set_name

#accessor for manu
sub get_manu {

	my($self) = (@_);
	return $self->{_manu};

}#close get_manu

#mutator for manu
sub set_manu{

	my($self, $new_manu) = (@_);
	$self->{_manu} = $new_manu;
	return $self->{_manu};

}#close set_manu

#accessor for rec_seq
sub get_rec_seq {

	my($self) = (@_);
	return $self->{_rec_seq};

}#close get_rec_seq

#mutator for rec_seq
sub set_rec_seq{

	my($self, $new_rec_seq) = (@_);
	$self->{_rec_seq} = $new_rec_seq;
	return $self->{_rec_seq};

}#close set_rec_seq

1;

=head1 RestrictionEnzyme
This module is written to hold the RestrictionEnzyme object in the name, manufacturer and rec_seq attributes. It contains a cut_dna method that applies the restriction enzyme to a given DNA sequence and returns an array of the fragments. It also contains accessor and mutator methods for all attributes
=cut
