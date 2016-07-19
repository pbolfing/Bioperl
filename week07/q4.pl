#! /usr/bin/perl

use strict;
use warnings;

print "Enter Number: ";
my $num = <STDIN>;
chomp ($num);

if ($num =~ /^\d+$/gm){

     print "Number is an Integer Only\n";

}
elsif ($num =~ /^\d*\.*\d$/gm){

     print "Number is either an integer or Decimal\n";

}
elsif ($num =~ /^-*\d*\.*\d*$/gm){

     print "Number is a positive or negative integer or decimal\n";

}
elsif ($num =~ /^-*\d*\.*\d*e\d+$/gm){

     print "Number is in scientific notation\n";

}
