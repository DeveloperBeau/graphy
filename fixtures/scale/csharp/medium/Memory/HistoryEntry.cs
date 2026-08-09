using System;

namespace Calc.Memory
{
    public class HistoryEntry
    {
        public string Expression { get; }
        public double Value { get; }
        public DateTime Stamp { get; }

        public HistoryEntry(string expression, double value)
        {
            Expression = expression;
            Value = value;
            Stamp = DateTime.Now;
        }

        public string Format()
        {
            return Expression + " => " + Value;
        }
    }
}
