using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Fnv1a32
{
    public class Fnv1a32Bench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new Fnv1a32Cipher();
            var vectors = Fnv1a32Vectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
