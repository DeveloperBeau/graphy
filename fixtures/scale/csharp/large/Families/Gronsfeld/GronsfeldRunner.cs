using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Gronsfeld
{
    public class GronsfeldRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new GronsfeldCipher();
            var vectors = GronsfeldVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
