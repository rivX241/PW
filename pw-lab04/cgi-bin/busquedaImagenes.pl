#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $q  = CGI->new;
my $imageSearch = $q->param('imageSearch') || '';

my $url = "https://www.google.com/search?tbm=isch&q=";
$url .= $q->escape($imageSearch) if $imageSearch;

print $q->redirect($url);