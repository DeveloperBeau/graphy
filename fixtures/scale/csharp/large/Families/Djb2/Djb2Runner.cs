using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Djb2
{
    public class Djb2Runner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new Djb2Cipher();
            var vectors = Djb2Vectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
