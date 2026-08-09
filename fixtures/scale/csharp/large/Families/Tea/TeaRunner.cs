using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Tea
{
    public class TeaRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new TeaCipher();
            var vectors = TeaVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
