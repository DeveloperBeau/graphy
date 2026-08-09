using System.Collections.Generic;

namespace TextPrint.Render
{
    public static class Wrapper
    {
        public static List<string> Wrap(string text, int width)
        {
            var lines = new List<string>();
            var current = "";
            foreach (var word in text.Split(' '))
            {
                if (current.Length > 0 && current.Length + word.Length + 1 > width)
                {
                    lines.Add(current);
                    current = word;
                }
                else
                {
                    current = current.Length == 0 ? word : current + " " + word;
                }
            }
            if (current.Length > 0)
            {
                lines.Add(current);
            }
            return lines;
        }
    }
}
