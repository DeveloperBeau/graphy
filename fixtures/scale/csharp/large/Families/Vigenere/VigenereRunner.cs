using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Vigenere
{
    public class VigenereRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new VigenereCipher();
            var vectors = VigenereVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
