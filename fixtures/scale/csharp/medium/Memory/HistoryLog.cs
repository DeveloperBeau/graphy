using System.Collections.Generic;

namespace Calc.Memory
{
    public class HistoryLog
    {
        private readonly List<HistoryEntry> _entries = new List<HistoryEntry>();

        public HistoryEntry Append(string expression, double value)
        {
            var entry = new HistoryEntry(expression, value);
            _entries.Add(entry);
            return entry;
        }

        public List<HistoryEntry> Recent(int count)
        {
            var start = _entries.Count > count ? _entries.Count - count : 0;
            return _entries.GetRange(start, _entries.Count - start);
        }

        public int Count()
        {
            return _entries.Count;
        }
    }
}
