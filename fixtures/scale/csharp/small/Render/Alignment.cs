using TextPrint.Util;

namespace TextPrint.Render
{
    public static class Alignment
    {
        public static string AlignLine(string line, int width, string mode)
        {
            var visible = TextMeasure.VisibleLength(line);
            var slack = width - visible;
            if (slack <= 0)
            {
                return line;
            }
            if (mode == "right")
            {
                return new string(' ', slack) + line;
            }
            if (mode == "center")
            {
                var left = slack / 2;
                return new string(' ', left) + line + new string(' ', slack - left);
            }
            return line + new string(' ', slack);
        }
    }
}
