package Calc::Parsing::TokenStream;
use strict;
use warnings;
use Calc::Lexing::Lexer;

sub new {
    my ($class, $source) = @_;
    my $lexer = Calc::Lexing::Lexer->new($source);
    my @tokens;
    while (1) {
        my $token = $lexer->next_token;
        push @tokens, $token;
        last if $token->kind eq 'END';
    }
    return bless { tokens => \@tokens, index => 0 }, $class;
}

sub current {
    my ($self) = @_;
    my $i = $self->{index} < $#{ $self->{tokens} } ? $self->{index} : $#{ $self->{tokens} };
    return $self->{tokens}[$i];
}

sub advance {
    my ($self) = @_;
    my $token = $self->current;
    $self->{index}++;
    return $token;
}

sub looks_like_assignment {
    my ($self) = @_;
    my @t = @{ $self->{tokens} };
    return @t > 2 && $t[0]->kind eq 'IDENT' && $t[1]->kind eq 'EQUALS';
}

1;
