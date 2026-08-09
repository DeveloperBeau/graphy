using System.Collections.Generic;

namespace CipherLab.Store
{
    public class SessionState
    {
        private readonly ResultsStore _store = new ResultsStore();

        public int PreviousSessions()
        {
            var runs = _store.PriorRuns();
            var families = new HashSet<string>();
            foreach (var record in runs)
            {
                families.Add(record.Family);
            }
            return families.Count == 0 ? 0 : runs.Count / families.Count;
        }

        public ResultsStore Store()
        {
            return _store;
        }
    }
}
