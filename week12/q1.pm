

package q1;

     use strict;
     use warnings;

     use Exporter 'import';
	our @EXPORT_OK = ("random_protein");

     #generate random protein of fixed or random length
	sub random_protein{
          
          #get user input	
          my @input = user_input();


          my $type = $input[0];
          my $len = $input[1];
          my $len_protein;
		my $protein = "";


          if ($type =~ m/[Ff]/){

               $len_protein = $len;

          }
          elsif ($type =~ m/[Rr]/){

               $len_protein = random_len($len);

          }#close elsif
          else {

               #if type exit
               print "Exiting, Bye.\n";
               $len_protein = $len;

          }

		for( my $i = 0; $i < $len_protein; $i++){

			$protein = $protein . random_aa();

		}#close for

		return "$protein\n";


	}#close rand_DNA

     #get user input
     sub user_input{

          #get length type
          print "Do you want a [F]ixed or [R]andom length protein?\n";
          my $type = <STDIN>;
          chomp $type;

          #check length type
          my $x = 1;
          while ($x == 1){

               if ($type =~ m/[^FRfrEe]/){
         
                    print "Input not recognized, please enter [F]ixed, [R]andom, or [E]\n";
                    $x = 1;

                    $type = <STDIN>;
                    chomp $type;           
                    
               }#close if
               elsif ($type =~ m/[Ee]/){

                    $x = 0

               }#close elsif
               else {

                    $x = 0;

               }#close else

          }#while

          #get length
          my $len;
          if ($type =~ m/[Ff]/){

               print "How long do you want your protein to be?\n";
               $len = <STDIN>;
               chomp $len;

          }#close if
          elsif ($type =~ m/[Rr]/){

               print "What do you want the max length of your protein to be?\n";
               $len = <STDIN>;
               chomp $len;

          }#close elsif
          elsif ($type =~ m/[Ee]/){

               $len = 0;               
               
          }#close elsif

          #check input length
          my $y = 1;
          while ($y == 1){
                            
               if ($len =~ m/[^0-9]/){

                    print "Please only use numerical characters and integer values!!\n";
                    print "Enter your length value: \n";
                    $y = 1;

                    $len = <STDIN>;
                    chomp $len;

               }#close if
               else {

                    $y = 0;

               }#close else

          }#close while

          my @input_array = ($type, $len);

          return @input_array;          

     }#close user_input


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
