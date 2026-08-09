using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.NibbleSwap
{
    public class NibbleSwapBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new NibbleSwapCipher();
            var vectors = NibbleSwapVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
