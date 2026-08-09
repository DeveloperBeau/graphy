using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Tea
{
    public class TeaBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new TeaCipher();
            var vectors = TeaVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
