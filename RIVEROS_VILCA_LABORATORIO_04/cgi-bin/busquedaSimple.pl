#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $q  = CGI->new;
my $simpleSearch = $q->param('simpleSearch')||'';

my $url = "https://www.google.com/search?q=";
$url .= $q->escape($simpleSearch) if $simpleSearch;
print $q->redirect($url);