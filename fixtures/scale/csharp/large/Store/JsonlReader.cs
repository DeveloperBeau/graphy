using System.Collections.Generic;
using System.IO;

namespace CipherLab.Store
{
    public class JsonlReader
    {
        private readonly string _path;

        public JsonlReader(string path)
        {
            _path = path;
        }

        public List<ResultRecord> ReadAll()
        {
            var records = new List<ResultRecord>();
            if (!File.Exists(_path))
            {
                return records;
            }
            foreach (var line in File.ReadAllLines(_path))
            {
                if (line.Length > 0)
                {
                    records.Add(ResultRecord.FromLine(line));
                }
            }
            return records;
        }
    }
}
