using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Substitution
{
    public class SubstitutionBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new SubstitutionCipher();
            var vectors = SubstitutionVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
