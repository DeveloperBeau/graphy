using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Caesar
{
    public class CaesarBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new CaesarCipher();
            var vectors = CaesarVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
