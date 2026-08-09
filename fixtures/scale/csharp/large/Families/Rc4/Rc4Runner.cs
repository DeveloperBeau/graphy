using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Rc4
{
    public class Rc4Runner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new Rc4Cipher();
            var vectors = Rc4Vectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
