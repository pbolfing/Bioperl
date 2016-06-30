#! /usr/bin/perl


use strict;
use warnings;

use q1 ('prod');


my $array = prod();


#input

print "Input == ";

for (my $i = 0; $i< 2; $i++) {

     print "(";     

     for (my $j = 0; $j<=2; $j++) {
          
          if ($j < 2) {

               print $array->[$i]->[$j], ", ";

          }#close if
          else {

               print $array->[$i]->[$j];

          }

     }#close j for

     if ($i < 1) {

          print ") and ";

     }#close if
     else {

          print ")\n";

     }#close else
}#close i for


#output

print "Output ==\n";

for (my $k = 0; $k<=2; $k++){

     print "     ";

     for (my $m = 0; $m<=2; $m++) {

          print (($array->[0]->[$k]) * ($array->[1]->[$m]));
          print " ";    

     }#close for m

     print "\n";

}#close for k







