using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Gronsfeld
{
    public class GronsfeldBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new GronsfeldCipher();
            var vectors = GronsfeldVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
