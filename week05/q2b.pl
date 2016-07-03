#! /usr/bin/perl

use strict;
use warnings;

use Storable;
use Data::Dumper;


my $dataref = retrieve('file');

for (my $i = 0; $i<10; $i++){

     print $dataref->[$i];
     print "\n";

}#close i for
