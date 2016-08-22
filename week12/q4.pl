#! /usr/bin/perl

use strict;
use warnings;

use Bio::SeqIO;

#get input from user
my ($in_file) = shift;
my ($out_format) = shift;

#get output file name
$in_file =~ /(\.\/)(.+\.)(\w+$)/;
my $out_file = "$2$out_format";

#create in and out objects
my $in = Bio::SeqIO->new(-file => $in_file);
my $out = Bio::SeqIO->new(-file => ">$out_file", -format => $out_format);

#read in and write to out 
while (my $seq = $in-> next_seq()){

     $out->write_seq($seq);

}#close while

print "Wrote ./$out_file\n";
