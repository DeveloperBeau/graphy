using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Scytale
{
    public class ScytaleRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new ScytaleCipher();
            var vectors = ScytaleVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
