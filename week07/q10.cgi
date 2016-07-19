#! /usr/bin/perl


use strict;
use warnings;

use DBI;
use CGI (':standard');

my $dbh = DBI->connect( "DBI:SQLite:dbname=test" , "" , "" ,
                        { PrintError => 0 , RaiseError => 1 } );


my $url = url();
my $title = 'Database Search';
print header, start_html("q10"), h1($title);

if (param('submit')) {

     my @search = param('search');

     my $select;

     #getting users selection for search
     foreach(@search){
     
          $select = "$select,($_)";
          
     }

     #create select statement
     my $sth = $dbh->prepare("SELECT $select FROM mRNA");

     #execute search
     $sth->execute();
     

     #print results
     print p("Your Results:"), '<ul>';
     
     while(my @row = $sth->fetchrow_array()){

          print @row;
     
     }     

     print '</ul>', hr();

}
  


print start_form(-method => 'GET', action => $url),
     p("What do you want to search: ".br().checkbox_group(-name => 'search', -values => ['gene_Name', 'tissue', 'organism', 'express'])),
     p(submit(-name=>'submit', value=>'Submit')),

     end_form(),
     end_html();


