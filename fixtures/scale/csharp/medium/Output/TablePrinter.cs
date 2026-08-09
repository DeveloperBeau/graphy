using System.Collections.Generic;
using System.Text;

namespace Calc.Output
{
    public class TablePrinter
    {
        private readonly string[] _headers;
        private readonly List<string[]> _rows = new List<string[]>();

        public TablePrinter(params string[] headers)
        {
            _headers = headers;
        }

        public void Add(params string[] cells)
        {
            _rows.Add(cells);
        }

        public string Render()
        {
            var sb = new StringBuilder();
            sb.AppendLine(string.Join(" | ", _headers));
            foreach (var row in _rows)
            {
                sb.AppendLine(string.Join(" | ", row));
            }
            return sb.ToString().TrimEnd();
        }
    }
}
