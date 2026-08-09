using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Caesar
{
    public class CaesarRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new CaesarCipher();
            var vectors = CaesarVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
