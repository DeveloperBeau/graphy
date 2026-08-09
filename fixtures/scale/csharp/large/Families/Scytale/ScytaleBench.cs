using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Scytale
{
    public class ScytaleBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new ScytaleCipher();
            var vectors = ScytaleVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
