namespace CipherLab.Report
{
    public static class DurationFormat
    {
        public static string PerOp(double nanos)
        {
            if (nanos < 1000)
            {
                return nanos.ToString("0.0") + "ns";
            }
            return (nanos / 1000).ToString("0.0") + "us";
        }
    }
}
