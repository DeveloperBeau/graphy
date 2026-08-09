using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Beaufort
{
    public class BeaufortRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new BeaufortCipher();
            var vectors = BeaufortVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
