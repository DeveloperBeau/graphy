using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Fnv1a32
{
    public class Fnv1a32Runner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new Fnv1a32Cipher();
            var vectors = Fnv1a32Vectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
