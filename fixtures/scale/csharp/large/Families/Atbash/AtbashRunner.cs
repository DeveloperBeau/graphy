using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Atbash
{
    public class AtbashRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new AtbashCipher();
            var vectors = AtbashVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
