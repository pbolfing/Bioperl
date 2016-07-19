#! /usr/bin/perl

#This is to show that my basic cgi form worked.  I was having trouble how exactly the search was to done in terms of how to determine the select, from and where portions of the search
#The search in q10.cgi is very basic but I believe should return results from the database created in week06, how I'm not sure if the results will print out as I desire as I couldn't
#that part of the code.


use strict;
use warnings;

#use DBI;
use CGI (':standard');


my $url = url();
my $title = 'Database Search';
print header, start_html("q10"), h1($title);

if (param('submit')) {

     my @search = param('search');

     my $select;

     #getting users selection for search
     #foreach(@search){
     
      #    $select = "$select,($_)";
          
     #}


     

     #print results
     print p("Your Results:"), '<ul>';  

     print '</ul>', hr();

}
  


print start_form(-method => 'GET', action => $url),
     p("What do you want to search: ".br().checkbox_group(-name => 'search', -values => ['gene_Name', 'tissue', 'organism', 'express'])),
     p(submit(-name=>'submit', value=>'Submit')),

     end_form(),
     end_html();
