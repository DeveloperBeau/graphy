using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Feistel
{
    public class FeistelBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new FeistelCipher();
            var vectors = FeistelVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
