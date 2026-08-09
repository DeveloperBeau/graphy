using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Feistel
{
    public class FeistelRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new FeistelCipher();
            var vectors = FeistelVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
