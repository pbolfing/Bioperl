#! /usr/bin/perl

use strict;
use warnings;
use CGI (':standard');
use Bio::DB::EUtilities;

#set titles
my $title_1 = "q1.cgi";
my $title_2 = "NCBI Global Query";

#print headers
print header, start_html($title_1), h1($title_2);

#handle form submission
if (param ('submit')){

     #get term and submit it
     my $q_term = param('term');
     my %results = get_results($q_term);

     #put results in table
     print "<table>";
     print "<tr><td>Database</td><td>Count</td></tr>";

     foreach my $key (keys %results){

          print "<tr><td>$key</td><td>$results{$key}</td></tr>";

     }#close for

     print "</table>";
     print hr();

}#close if

#print base form
my $url = url();
print start_form(-method => 'GET', action => $url),
     p("What is your query term: " . textfield (-name => 'q_term')),
     p(submit(-name => 'submit', value => 'Submit')),
     end_form(),
     end_html();
     

#does actual submission and gets results
sub get_results {

     my($term) = @_;
     my $fac = Bio::DB::EUtilites->new(-eutil => 'egquery', -term => $term);

     #variables to hold results
     my %results = ();
     my $db = "";
     my $count = "";

     #get each database name and count
     while (my $g_query = $fac->next_GlobalQuery){

          $db = $g_query->get_database;
          $count = $g_query->get_count;

          $results{$db} = $count; 

     }#close while

     return %results;

}#close get_results



