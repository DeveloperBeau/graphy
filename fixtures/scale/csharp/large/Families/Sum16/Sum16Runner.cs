using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Sum16
{
    public class Sum16Runner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new Sum16Cipher();
            var vectors = Sum16Vectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
