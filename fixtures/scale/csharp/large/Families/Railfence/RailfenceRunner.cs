using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Railfence
{
    public class RailfenceRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new RailfenceCipher();
            var vectors = RailfenceVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
