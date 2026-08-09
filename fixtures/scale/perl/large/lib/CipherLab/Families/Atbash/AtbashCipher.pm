package CipherLab::Families::Atbash::AtbashCipher;
use strict;
use warnings;

sub new {
    my ($class) = @_;
    return bless { shift => 5, step => 3 }, $class;
}

sub name { return 'atbash' }

sub encode {
    my ($self, $plaintext) = @_;
    my @chars = split //, $plaintext;
    for my $i (0 .. $#chars) {
        next unless $chars[$i] =~ /[A-Z]/;
        my $shifted = (ord($chars[$i]) - 65 + $self->{shift} + $i * $self->{step}) % 26;
        $chars[$i] = chr(65 + $shifted);
    }
    return join '', @chars;
}

sub decode {
    my ($self, $ciphertext) = @_;
    my @chars = split //, $ciphertext;
    for my $i (0 .. $#chars) {
        next unless $chars[$i] =~ /[A-Z]/;
        my $shifted = ((ord($chars[$i]) - 65 - $self->{shift} - $i * $self->{step}) % 26 + 2600) % 26;
        $chars[$i] = chr(65 + $shifted);
    }
    return join '', @chars;
}

1;
