package CipherLab::Families::Feistel::FeistelCipher;
use strict;
use warnings;

sub new {
    my ($class) = @_;
    return bless { rounds => 3 }, $class;
}

sub name { return 'feistel' }

sub encode {
    my ($self, $plaintext) = @_;
    my $out = '';
    for my $b (unpack('C*', $plaintext)) {
        my $rotated = (($b << $self->{rounds}) | ($b >> (8 - $self->{rounds}))) & 0xFF;
        $out .= sprintf('%02x', $rotated);
    }
    return $out;
}

sub decode {
    my ($self, $ciphertext) = @_;
    my $out = '';
    for (my $i = 0; $i < length($ciphertext); $i += 2) {
        my $value = hex(substr($ciphertext, $i, 2));
        my $back = (($value >> $self->{rounds}) | ($value << (8 - $self->{rounds}))) & 0xFF;
        $out .= chr($back);
    }
    return $out;
}

1;
