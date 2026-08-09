using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Xtea
{
    public class XteaBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new XteaCipher();
            var vectors = XteaVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
