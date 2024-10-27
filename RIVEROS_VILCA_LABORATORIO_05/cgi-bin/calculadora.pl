#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $q = CGI->new;
print $q->header(-type => 'text/html', -charset => 'UTF-8');

my $operacion = $q->param('operacion') || "";

my $resultado = "";
if (defined $operacion && $operacion ne '') {
    chomp($operacion);
    $resultado = evaluar($operacion);
}

sub evaluar {
    my ($expresion) = @_;

    $expresion =~ s/[^0-9+\-*\/\(\)\s]//g;

    my @tokens = tokenizar($expresion);
    my @salida = infija_a_postfija(@tokens);
    my $resultado = evaluar_rpn(@salida);

    return $resultado;
}

sub tokenizar {
    my ($expresion) = @_;
    my @tokens = ($expresion =~ /(\d+|\+|\-|\*|\/|\(|\))/g);
    return @tokens;
}

sub infija_a_postfija {
    my @tokens = @_;
    my @salida;
    my @stack;

    my %precedencia = (
        '+' => 1,
        '-' => 1,
        '*' => 2,
        '/' => 2,
    );

    for my $token (@tokens) {
        if ($token =~ /^[0-9]+$/) {  
            push @salida, $token;
        } elsif ($token eq '(') {
            push @stack, $token;
        } elsif ($token eq ')') {
            while (@stack && $stack[-1] ne '(') {
                push @salida, pop @stack;
            }
            pop @stack; 
        } else {  
            while (@stack && $precedencia{$token} <= $precedencia{$stack[-1]}) {
                push @salida, pop @stack;
            }
            push @stack, $token;
        }
    }
    push @salida, pop @stack while @stack;
    return @salida;
}

sub evaluar_rpn {
    my @tokens = @_;
    my @pila;

    for my $token (@tokens) {
        if ($token =~ /^[0-9]+$/) {
            push @pila, $token;
        } else {
            my $b = pop @pila;
            my $a = pop @pila;
            if ($token eq '+') {
                push @pila, $a + $b;
            } elsif ($token eq '-') {
                push @pila, $a - $b;
            } elsif ($token eq '*') {
                push @pila, $a * $b;
            } elsif ($token eq '/') {
                push @pila, $b == 0 ? "No se puede dividir por cero" : $a / $b;
            }
        }
    }
    return pop @pila;
}

print <<HTML;
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Calculadora</title>
        <link rel="stylesheet" type="text/css" href="/css/styles.css">
    </head>
    <body>
        <div class="titulo"><h1>Calculadora :D</h1></div>
        <div class="calculadora">
            <form action="/cgi-bin/calculadora.pl" method="GET">
                <input class="entrada" type="text" name="operacion" placeholder="Ingrese la operación a realizar" value="$operacion">
                <input class="botonSubir" type="submit" value="Calcular">
            </form>
        </div>
        <div class="resultado">
                <h3>Resultado: $resultado</h3>
        </div>
    </body>
</html>
HTML