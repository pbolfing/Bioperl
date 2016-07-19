#! /usr/bin/perl

use strict;
use warnings;


my @num_array = (17, 4, 19, 46, 3, 86,37);

my $max_res = max_num (@num_array);
my $min_res = min_num (@num_array);

print "Max is $max_res\n";
print "Min is $min_res\n";

sub min_num {

     my @nums = @_;

     my @s_nums = sort {$a <=> $b} @nums;

     return $s_nums[0];

}#close min_num


sub max_num {

     my @nums = @_;

     my @s_nums = sort {$a <=> $b} @nums;

     return $s_nums[-1];

}
