using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Store
{
    public class ResultsStore
    {
        private readonly JsonlWriter _writer;
        private readonly JsonlReader _reader;

        public ResultsStore()
        {
            _writer = new JsonlWriter(StorePaths.ResultsFile());
            _reader = new JsonlReader(StorePaths.ResultsFile());
        }

        public List<ResultRecord> PriorRuns()
        {
            return _reader.ReadAll();
        }

        public void Persist(List<ResultRecord> records)
        {
            _writer.Append(records);
        }
    }
}
