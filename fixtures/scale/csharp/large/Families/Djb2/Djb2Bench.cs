using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Djb2
{
    public class Djb2Bench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new Djb2Cipher();
            var vectors = Djb2Vectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
