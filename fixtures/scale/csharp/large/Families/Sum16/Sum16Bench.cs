using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Sum16
{
    public class Sum16Bench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new Sum16Cipher();
            var vectors = Sum16Vectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
