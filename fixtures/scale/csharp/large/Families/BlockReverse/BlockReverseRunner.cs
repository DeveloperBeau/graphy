using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.BlockReverse
{
    public class BlockReverseRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new BlockReverseCipher();
            var vectors = BlockReverseVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
