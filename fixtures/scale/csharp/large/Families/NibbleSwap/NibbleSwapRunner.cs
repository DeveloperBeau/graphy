using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.NibbleSwap
{
    public class NibbleSwapRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new NibbleSwapCipher();
            var vectors = NibbleSwapVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
