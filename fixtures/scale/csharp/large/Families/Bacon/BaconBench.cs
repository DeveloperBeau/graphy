using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Bacon
{
    public class BaconBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new BaconCipher();
            var vectors = BaconVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
