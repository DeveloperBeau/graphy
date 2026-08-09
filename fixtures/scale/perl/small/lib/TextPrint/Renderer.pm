package TextPrint::Renderer;
use strict;
use warnings;
use TextPrint::Wrapper;
use TextPrint::Alignment;
use TextPrint::Border;
use TextPrint::Theme;

sub new {
    my ($class, $options) = @_;
    my $theme = TextPrint::Theme::named($options->themeName);
    return bless { options => $options, theme => $theme }, $class;
}

sub render {
    my ($self, $text) = @_;
    my $options = $self->{options};
    my @lines = TextPrint::Wrapper::wrap($text, $options->width);
    my @aligned = map { TextPrint::Alignment::align_line($_, $options->width, $options->align) } @lines;
    if ($options->borderStyle ne 'none') {
        my $border = TextPrint::Border->new($options->borderStyle);
        @aligned = $border->frame($options->width, @aligned);
    }
    return $self->{theme}->apply(join "\n", @aligned);
}

1;
