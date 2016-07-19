#! /usr/bin/perl

use strict;
use warnings;


print "Enter DNA Sequence: ";
my $seq = <STDIN>;
chomp ($seq);

my $temp = 0;
my $gc = 0;

foreach my $char (split //, $seq){

     if ($char eq "A" || $char eq "T"){

          $temp = $temp + 2;          

     }#close if
     elsif ($char eq "G" || $char eq "C"){

          $temp = $temp + 4;

          $gc = $gc + 1;

     }#close elsif

}#close foreach

my $per_gc = $gc/length($seq);


print "The annealing temperature of the oligomer is $temp C\n";
print "The oligomer is $per_gc % G or C\n";

