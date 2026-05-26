package Service;

use strict;
use warnings;
use Helpers qw(format_name);

sub new {
    my ($class, $name) = @_;
    my $self = { name => $name };
    return bless $self, $class;
}

sub run {
    my ($self) = @_;
    my $greeting = format_name($self->{name});
    return $greeting;
}

sub describe {
    my ($self) = @_;
    return "Service($self->{name})";
}

1;
