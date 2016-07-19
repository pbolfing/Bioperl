

package q8;

     #I took the question to mean that ATG should always be the first codon of the sequence

     use strict;
     use warnings;

     use Exporter 'import';
	our @EXPORT_OK = ("translate_dna");

     sub translate_dna {
        
          my ($in_seq) = (@_);
          #chomp ($in_seq);
          #change to all caps
          $in_seq = uc($in_seq);

          my $x = 0;
          my $y = 0;
          my $a = 0;
          my $out_seq;

          #check for start codon
          if ($in_seq =~ /^ATG/){

               $x = 1;
          }
          if ($x != 1){
     
               die("Sequence doesn't contain a start codon, can't process\n");

          }#close if

          #check for only nucleotides
          if ($in_seq =~ /[^ATGC]/){

               $a = 1;

          }
          #exit if non nucleotide found
          if ($a !=0) {

               die ("Non-nucleotide characters found in sequence, can't process\n");

          }#close if

          #check length
          my $len;
          if (length($in_seq)%3 != 0){

               print "Warning not all nucleotides will be processed due to unfilled codon\n";
               my $z = length($in_seq)%3;
               $len = length($in_seq)-$z;     
     
          }
          else{

               $len = length($in_seq);

          }

          #check for stop codon
          if ($in_seq =~ /TAA/ || $in_seq=~/TAG/ || $in_seq=~ /TGA/){

               $y = 1;

          }
          if ($y != 1) {

               print "Warning there is no stop codon, sequence will be processed to very end\n";

          }

          #all checks done, time to run

          my $char = '';
          for (my $i = 0; $i < $len; $i=$i+3){

               $char = amino_acid(substr($in_seq, $i, 3));


               if ($char eq 'stop'){

                    $i = $len;

               }#close if
               else{

                    $out_seq .= $char;

               }#close else

          }#close for
          #print $out_seq,"\n";

          return $out_seq;

     }#close translate_dna


     sub amino_acid {

          my ($codon) = (@_);

          my %amino = (TTT=>'Phe',TTC=>'Phe',TTA=>'Leu',TTG=>'Leu',CTT=>'Leu',CTC=>'Leu',CTA=>'Leu',CTG=>'Leu',ATT=>'Ile',ATC=>'Ile',ATA=>'Ile',ATG=>'Met',GTT=>'Val',GTC=>'Val',GTA=>'Val',GTG=>'Val',
                         TCT=>'Ser',TCC=>'Ser',TCA=>'Ser',TCG=>'Ser',CCT=>'Pro',CCC=>'Pro',CCA=>'Pro',CCG=>'Pro',ACT=>'Thr',ACC=>'Thr',ACA=>'Thr',ACG=>'Thr',GCT=>'Ala',GCC=>'Ala',GCA=>'Ala',GCG=>'Ala',
                         TAT=>'Tyr',TAC=>'Tyr',CAT=>'His',CAC=>'His',CAA=>'Gin',CAG=>'Gin',AAT=>'Asn',AAC=>'Asn',AAA=>'Lys',AAG=>'Lys',GAT=>'Asp',GAC=>'Asp',GAA=>'Glu',GAG=>'Glu',TGT=>'Cys',TGC=>'Cys',
                         TGG=>'Trp',CGT=>'Arg',CGC=>'Arg',CGA=>'Arg',CGG=>'Arg',AGT=>'Ser',AGC=>'Ser',AGA=>'Arg',AGG=>'Arg',GGT=>'Gly',GGC=>'Gly',GGA=>'Gly',GGG=>'Gly',TAA=>'stop',TAG=>'stop',TGA=>'stop');

          my $acid = $amino{$codon};

          return $acid;

     }#close amino_acid

1;   
