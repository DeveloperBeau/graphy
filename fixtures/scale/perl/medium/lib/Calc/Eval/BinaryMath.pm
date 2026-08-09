package Calc::Eval::BinaryMath;
use strict;
use warnings;

sub apply {
    my ($op, $left, $right) = @_;
    return $left + $right if $op eq '+';
    return $left - $right if $op eq '-';
    return $left * $right if $op eq '*';
    return $right == 0 ? die("division by zero\n") : $left / $right if $op eq '/';
    return $left % $right if $op eq '%';
    return $left ** $right if $op eq '^';
    die "unknown operator: $op\n";
}

1;
