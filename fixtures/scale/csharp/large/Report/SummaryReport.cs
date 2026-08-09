using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Report
{
    public class SummaryReport
    {
        public string Build(List<VectorOutcome> outcomes, int priorSessions)
        {
            var passed = 0;
            foreach (var outcome in outcomes)
            {
                if (outcome.Passed)
                {
                    passed++;
                }
            }
            var table = new TableRenderer();
            table.Row("metric", "value");
            table.Row("families", outcomes.Count.ToString());
            table.Row("passed", passed.ToString());
            table.Row("prior sessions", priorSessions.ToString());
            return table.Render();
        }
    }
}
