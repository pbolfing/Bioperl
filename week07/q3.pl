#! /usr/bin/perl

use strict;
use warnings;


print "Enter Temperature: ";
my $temp = <STDIN>;
chomp ($temp);
print "Enter Unit (C or F): ";
my $unit = <STDIN>;
chomp ($unit);


if ($unit eq "C"){

     my $result = C_to_F($temp);
     print "$temp C is $result F\n";     

}#close if
elsif ($unit eq "F"){

     my $result = F_to_C($temp);
     print "$temp F is $result C\n";

}#close elsif
else {

     print "Invalid Unit enter, Bye!!\n";

}#close else





sub C_to_F {

     my ($in_temp) = (@_);
     my $out_temp;

     $out_temp = ($in_temp*9/5) +32;

     return $out_temp;

}


sub F_to_C {

     my ($temp_in) = (@_);
     my $temp_out;

     $temp_out = ($temp_in - 32)/(9/5);

     return $temp_out;

}
