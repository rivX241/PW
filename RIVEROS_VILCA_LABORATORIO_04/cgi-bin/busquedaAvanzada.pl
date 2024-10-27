#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $q  = CGI->new;
my $todasEstasPalabras = $q->param('allwords') || '';
my $estaPalabraFrase = $q->param('thisSentence') || '';
my $ningunaDeEstasPalabras = $q->param('noWords') || '';

my $url = "https://www.google.com/search?q=";
$url .= $q->escape($todasEstasPalabras) if $todasEstasPalabras;
$url .= "+\"" . $q->escape($estaPalabraFrase) . "\"" if $estaPalabraFrase;
$url .= "+-" . $q->escape($ningunaDeEstasPalabras) if $ningunaDeEstasPalabras;

print $q->redirect($url);

