package TextPrint::AnsiPalette;
use strict;
use warnings;

use constant RESET => "\e[0m";
use constant BOLD  => "\e[1m";
use constant DIM   => "\e[2m";

sub reset { return RESET }
sub bold  { return BOLD }
sub dim   { return DIM }

1;
