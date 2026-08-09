using System.Collections.Generic;
using CipherLab.Abstractions;
using CipherLab.Registry;

namespace CipherLab.Report
{
    public class SuiteReport
    {
        public string Build(List<VectorOutcome> outcomes)
        {
            var table = new TableRenderer();
            table.Row("suite", "families");
            foreach (var suite in SuiteMap.SuiteNames())
            {
                table.Row(suite, SuiteMap.Grouped()[suite].Count.ToString());
            }
            return table.Render();
        }
    }
}
