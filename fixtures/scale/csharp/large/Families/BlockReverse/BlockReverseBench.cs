using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.BlockReverse
{
    public class BlockReverseBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new BlockReverseCipher();
            var vectors = BlockReverseVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
