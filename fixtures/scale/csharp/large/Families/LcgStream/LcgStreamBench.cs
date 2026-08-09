using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.LcgStream
{
    public class LcgStreamBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new LcgStreamCipher();
            var vectors = LcgStreamVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
