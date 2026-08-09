using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Adler32
{
    public class Adler32Runner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new Adler32Cipher();
            var vectors = Adler32Vectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
