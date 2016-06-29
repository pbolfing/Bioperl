#! /usr/bin/perl


use strict;
use warnings;

use Test::Simple tests => 2;

use q3 ('rand_DNA');


my $dna = rand_DNA (75, "option");
my $len = 75;

ok( (length($dna) >= 1 && length($dna) <= $len ), "string length ok");


my $len2 = length($dna);

ok( $dna =~ /^[ACGT]{$len2}$/i , "string composition checks" );


#print "$dna";
#print length($dna);
