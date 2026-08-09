using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Atbash
{
    public class AtbashBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new AtbashCipher();
            var vectors = AtbashVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
