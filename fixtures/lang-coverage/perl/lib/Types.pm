package Types;

use strict;
use warnings;

our $MAX_RETRIES = 3;
our $SERVICE_NAME = "graphy-perl-fixture";

sub new {
    my ($class) = @_;
    return bless {}, $class;
}

1;
