package CipherLab::Store::ResultsStore;
use strict;
use warnings;
use CipherLab::Store::StorePaths;
use CipherLab::Store::ResultRecord;

sub prior_runs {
    my $path = CipherLab::Store::StorePaths::results_file();
    return () unless -f $path;
    open my $fh, '<', $path or return ();
    my @records = map { chomp; CipherLab::Store::ResultRecord::from_line($_) } <$fh>;
    close $fh;
    return @records;
}

sub persist {
    my (@records) = @_;
    CipherLab::Store::StorePaths::ensure_dir();
    open my $fh, '>>', CipherLab::Store::StorePaths::results_file() or die $!;
    print $fh $_->to_line, "\n" for @records;
    close $fh;
}

1;
