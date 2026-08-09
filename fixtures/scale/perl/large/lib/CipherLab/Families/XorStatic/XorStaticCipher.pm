package CipherLab::Families::XorStatic::XorStaticCipher;
use strict;
use warnings;

sub new {
    my ($class) = @_;
    return bless { mask => 5 }, $class;
}

sub name { return 'xorstatic' }

sub encode {
    my ($self, $plaintext) = @_;
    my @bytes = unpack('C*', $plaintext);
    my $out = '';
    for my $i (0 .. $#bytes) {
        $out .= sprintf('%02x', ($bytes[$i] ^ ($self->{mask} + $i)) & 0xFF);
    }
    return $out;
}

sub decode {
    my ($self, $ciphertext) = @_;
    my $out = '';
    for (my $i = 0; $i < length($ciphertext); $i += 2) {
        my $value = hex(substr($ciphertext, $i, 2));
        $out .= chr(($value ^ ($self->{mask} + $i / 2)) & 0xFF);
    }
    return $out;
}

1;
