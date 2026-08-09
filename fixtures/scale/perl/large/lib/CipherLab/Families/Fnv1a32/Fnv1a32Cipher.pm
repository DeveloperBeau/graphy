package CipherLab::Families::Fnv1a32::Fnv1a32Cipher;
use strict;
use warnings;

sub new {
    my ($class) = @_;
    return bless { seed => 2166136261, prime => 16777619 }, $class;
}

sub name { return 'fnv1a32' }

sub encode {
    my ($self, $plaintext) = @_;
    my $acc = $self->{seed};
    for my $b (unpack('C*', $plaintext)) {
        $acc = (($acc ^ $b) * $self->{prime}) & 0xFFFFFFFF;
    }
    return sprintf('%08x', $acc);
}

sub decode {
    my ($self, $ciphertext) = @_;
    return "digest:$ciphertext";
}

1;
