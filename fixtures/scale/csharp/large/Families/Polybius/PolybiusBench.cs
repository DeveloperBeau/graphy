using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Polybius
{
    public class PolybiusBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new PolybiusCipher();
            var vectors = PolybiusVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
