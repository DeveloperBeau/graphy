using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Rot13
{
    public class Rot13Runner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new Rot13Cipher();
            var vectors = Rot13Vectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
