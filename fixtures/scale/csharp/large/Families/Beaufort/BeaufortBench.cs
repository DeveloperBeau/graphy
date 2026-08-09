using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Beaufort
{
    public class BeaufortBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new BeaufortCipher();
            var vectors = BeaufortVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
