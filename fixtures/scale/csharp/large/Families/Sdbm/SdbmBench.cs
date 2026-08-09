using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Sdbm
{
    public class SdbmBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new SdbmCipher();
            var vectors = SdbmVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
