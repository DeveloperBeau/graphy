using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Rot13
{
    public class Rot13Bench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new Rot13Cipher();
            var vectors = Rot13Vectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
