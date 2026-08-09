using System;

namespace CipherLab.Engine
{
    public class ProgressReporter
    {
        private readonly int _total;
        private int _done;

        public ProgressReporter(int total)
        {
            _total = total;
        }

        public void Step(string family, bool passed)
        {
            _done++;
            var flag = passed ? "ok " : "BAD";
            Console.Error.Write("\r[" + _done + "/" + _total + "] " + flag + " " + family + "        ");
            if (_done == _total)
            {
                Console.Error.WriteLine();
            }
        }
    }
}
