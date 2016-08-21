package q3;

     use Moose;
     use Moose::Util::TypeConstraints;

     subtype 'len_type'
          => as 'Str'
          => where {$_ =~ /([Ff]ixed|[Rr]andom)/ }
          => message {"The Sequece Length Type entered is not recognized"};

     has len_type => (is => 'rw', isa => 'len_type', required => 1);
     has len => (is => 'rw', isa => 'Int', required => 1);
     has protein => (is => 'rw', builder => 'random_protein');

     #generate random protein of fixed or random length
	sub random_protein{
          
          #get user input	
          my $self = shift;


          my $len_type = $self->len_type;
          my $len = $self->len;
          my $len_protein;
		my $protein = "";

          #print $len_type, "\n";
          #print $len, "\n";


          if ($len_type =~ /[Ff]ixed/){

               $len_protein = $len;
               #print $len_protein, "\n";

          }
          elsif ($len_type =~ /[Rr]andom/){

               $len_protein = random_len($len);
               #print $len_protein, "\n";

          }#close elsif


		for( my $i = 0; $i < $len_protein; $i++){

			$protein = $protein . random_aa();

		}#close for

		return "$protein\n";


	}#close random_protein


     #generate random length
	sub random_len{

		my ($x) = (@_);

		return (int( rand($x))+1);

	}#close random_len

     #generate random amino acid
	sub random_aa{

		my (@aa_array) = ('A', 'R', 'N', 'D', 'C', 'E', 'Q', 'G', 'H', 'I', 'L', 'K', 'M', 'F', 'P', 'S', 'T', 'W', 'Y', 'V');

		my $aa = $aa_array[rand @aa_array];

		return ($aa);


	}#close random_aa

1;
