package CipherLab::Cli::Config;
use strict;
use warnings;

# Run-level settings parsed from the command line by Cli::ArgParser.
# Kept as a plain hashref since there is no behavior beyond storage.
sub defaults {
    return { iterations => 2000, suiteFilter => 'all', persist => 1 };
}

1;
