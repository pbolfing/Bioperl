#! /usr/bin/perl


use strict;
use warnings;


my $file = "data.fasta";
open(my $IN, '<', $file) or die ("Can't open $file ($!)");


my @seq_array = ();
my @head_array = ();
my @gene_Name = ();
my @org = ();
my @tis = ();
my @express = ();
my @start = ();
my @stop = ();

my $seq = "";

my $i = 0;

     while (my $line = <$IN>){

          
          #header
          if ($line =~ /^>/){
          
               chomp ($line);              
               $head_array[$i] = ($line);

          }#close if
          elsif ($line =~ /^\s*$/) {

               $seq =~ s/\s+$//;  #trim white space
               $seq_array[$i] = $seq;

               $i = $i + 1;
               $seq = "";

          }#close elsif
          else {

               $seq .= ($line);

          }#close else

     }#close while
     
     $seq =~ s/\s+$//;
     $seq_array[$i] = $seq;



     for (my $k = 0; $k <2; $k++) {

          $head_array[$k] =~ /> (.+) \| (.+) \| (.+) \| (\d+) \| (\d+) \| (\d+)/;

          $gene_Name[$k] = $1;
          $org[$k] = $2;
          $tis[$k] = $3;
          $express[$k] = $4;
          $start[$k] = $5;
          $stop[$k] = $6;



     }#close for




     close $IN;
