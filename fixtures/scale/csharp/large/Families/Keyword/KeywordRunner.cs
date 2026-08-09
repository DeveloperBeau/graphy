using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Keyword
{
    public class KeywordRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new KeywordCipher();
            var vectors = KeywordVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
