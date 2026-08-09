using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.LcgStream
{
    public class LcgStreamRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new LcgStreamCipher();
            var vectors = LcgStreamVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
