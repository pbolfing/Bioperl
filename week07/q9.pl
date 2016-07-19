#! /usr/bin/perl


use strict;
use warnings;

use Test::Simple tests => 5;
#use Test::Exception tests => 1;

use q8 ('translate_dna');

#ideal sequence
#my $seq = translate_dna ("ATGGTTGCCAAATGA");

ok( (translate_dna("ATGGTTGCCAAATGA") eq "MetValAlaLys"), "Translation Ok");

ok( (length(translate_dna("ATGGTTGCCAAATGA"))/3 == 4), "Translation Length Ok");

#no stop codon
ok( (translate_dna("ATGGTTGCCAAA") eq "MetValAlaLys"), "Translation Ok with missing stop codon");

ok ( (length(translate_dna("ATGGTTGCCAAA"))/3 ==4), "Translation Length Ok with mission stop codon");

#lower case
ok( (translate_dna("ATGgttGCCAAATGA") eq "MetValAlaLys"), "Translation ok with lower case");

#dies_ok{translate_dna("GTTGCCAAATGA")} "Dies ok when no start codon detected";

#Was going to test to ensure that my program dies as it supposed to when start codon isn't detected or when foreign character found but Test::Expection is not currently installed on my system



