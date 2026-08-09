using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Autokey
{
    public class AutokeyBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new AutokeyCipher();
            var vectors = AutokeyVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
