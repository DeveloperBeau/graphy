using System.Collections.Generic;

namespace TextPrint.Render
{
    public class Border
    {
        private readonly char _horizontal;
        private readonly char _vertical;
        private readonly char _corner;

        public Border(string style)
        {
            _horizontal = style == "double" ? '=' : '-';
            _vertical = style == "ascii" ? '|' : '\u2502';
            _corner = '+';
        }

        public List<string> Frame(List<string> lines, int width)
        {
            var rule = _corner + new string(_horizontal, width + 2) + _corner;
            var framed = new List<string> { rule };
            foreach (var line in lines)
            {
                framed.Add(_vertical + " " + line + " " + _vertical);
            }
            framed.Add(rule);
            return framed;
        }
    }
}
