#! /usr/bin/perl

use strict;
use warnings;

print "Enter your values:\n";


#get user input
my @array1;
my @array2;
my @array3;
my @w_array = (\@array1, \@array2, \@array3);

for (my $j = 0; $j < 3; $j++) {

     my $value = <STDIN>;
     chomp ($value);  
     if ($j < 1){
   
          @array1 =split (' ', $value);

     }#close if
     elsif ($j > 0 && $j<2){

          @array2 = split (' ', $value);

     }#close elsif
     elsif ($j>1) {

          @array3 = split(' ', $value);

     }#close elsif

}#close for

#create reference
my $array = \@w_array;

print "Result: \n";

#print results
for (my $i = 0; $i < 3; $i++){

     for (my $k = 0; $k < 3; $k++){

          print $array->[$k]->[$i], " ";

     }#close inner for

     print "\n";

}#close outer for

