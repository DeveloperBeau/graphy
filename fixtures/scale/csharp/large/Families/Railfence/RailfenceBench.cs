using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Railfence
{
    public class RailfenceBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new RailfenceCipher();
            var vectors = RailfenceVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
