#!  /usr/bin/perl

use strict;
use warnings;


my $hash_result = hash_Func();

foreach (keys %$hash_result){
     
     print "$_ --> ${$hash_result}{$_}\n";


}#close foreach

sub hash_Func {

     my %hash_var = ( CGC => 'arg', AUG => 'met');

     my $hash_ref = \%hash_var;

     return ($hash_ref);


}
