using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Trithemius
{
    public class TrithemiusBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new TrithemiusCipher();
            var vectors = TrithemiusVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
