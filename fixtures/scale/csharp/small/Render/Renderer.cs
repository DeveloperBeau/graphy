using System.Collections.Generic;
using TextPrint.Cli;
using TextPrint.Style;

namespace TextPrint.Render
{
    public class Renderer
    {
        private readonly Options _options;
        private readonly Theme _theme;

        public Renderer(Options options)
        {
            _options = options;
            _theme = Theme.Named(options.ThemeName);
        }

        public string Render(string text)
        {
            var lines = Wrapper.Wrap(text, _options.Width);
            var aligned = new List<string>();
            foreach (var line in lines)
            {
                aligned.Add(Alignment.AlignLine(line, _options.Width, _options.Align));
            }
            if (_options.BorderStyle != "none")
            {
                aligned = new Border(_options.BorderStyle).Frame(aligned, _options.Width);
            }
            return _theme.Apply(string.Join("\n", aligned));
        }
    }
}
