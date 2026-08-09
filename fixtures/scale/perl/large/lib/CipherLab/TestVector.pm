package CipherLab::TestVector;
use strict;
use warnings;

sub new {
    my ($class, $plaintext, $expected) = @_;
    return bless { plaintext => $plaintext, expected => $expected }, $class;
}

sub plaintext { return $_[0]->{plaintext} }
sub expected  { return $_[0]->{expected} }

1;
