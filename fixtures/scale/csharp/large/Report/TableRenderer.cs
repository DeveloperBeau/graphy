using System.Collections.Generic;
using System.Text;

namespace CipherLab.Report
{
    public class TableRenderer
    {
        private readonly List<string[]> _rows = new List<string[]>();

        public void Row(params string[] cells)
        {
            _rows.Add(cells);
        }

        public string Render()
        {
            var sb = new StringBuilder();
            foreach (var row in _rows)
            {
                sb.AppendLine(string.Join("  ", row));
            }
            return sb.ToString().TrimEnd();
        }
    }
}
