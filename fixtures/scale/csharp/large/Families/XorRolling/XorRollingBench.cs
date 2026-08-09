using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.XorRolling
{
    public class XorRollingBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new XorRollingCipher();
            var vectors = XorRollingVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
