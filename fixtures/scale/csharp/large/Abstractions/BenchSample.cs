namespace CipherLab.Abstractions
{
    public class BenchSample
    {
        public string Family { get; }
        public long Nanoseconds { get; }
        public int Iterations { get; }

        public BenchSample(string family, long nanoseconds, int iterations)
        {
            Family = family;
            Nanoseconds = nanoseconds;
            Iterations = iterations;
        }

        public double PerOp()
        {
            return Iterations == 0 ? 0 : (double)Nanoseconds / Iterations;
        }
    }
}
