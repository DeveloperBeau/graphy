package Calc::Parsing::Precedence;
use strict;
use warnings;

my %PRECEDENCE = ('+' => 1, '-' => 1, '*' => 2, '/' => 2, '%' => 2, '^' => 3);

sub of { return $PRECEDENCE{ $_[0] } // 0 }

sub right_associative { return $_[0] eq '^' }

1;
