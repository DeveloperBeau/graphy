using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Affine
{
    public class AffineBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new AffineCipher();
            var vectors = AffineVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
