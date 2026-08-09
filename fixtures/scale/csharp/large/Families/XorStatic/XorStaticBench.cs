using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.XorStatic
{
    public class XorStaticBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new XorStaticCipher();
            var vectors = XorStaticVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
