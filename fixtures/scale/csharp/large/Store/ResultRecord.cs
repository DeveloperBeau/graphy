namespace CipherLab.Store
{
    public class ResultRecord
    {
        public string Family { get; set; }
        public string Suite { get; set; }
        public bool Passed { get; set; }
        public long Nanoseconds { get; set; }

        public string ToLine()
        {
            var flag = Passed ? "1" : "0";
            return string.Join("\t", Family, Suite, flag, Nanoseconds.ToString());
        }

        public static ResultRecord FromLine(string line)
        {
            var parts = line.Split('\t');
            return new ResultRecord
            {
                Family = parts[0],
                Suite = parts[1],
                Passed = parts[2] == "1",
                Nanoseconds = long.Parse(parts[3])
            };
        }
    }
}
