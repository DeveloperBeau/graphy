using System.Collections.Generic;
using System.IO;

namespace CipherLab.Store
{
    public class JsonlWriter
    {
        private readonly string _path;

        public JsonlWriter(string path)
        {
            _path = path;
        }

        public void Append(IEnumerable<ResultRecord> records)
        {
            StorePaths.EnsureDir();
            using var stream = new StreamWriter(_path, append: true);
            foreach (var record in records)
            {
                stream.WriteLine(record.ToLine());
            }
        }
    }
}
