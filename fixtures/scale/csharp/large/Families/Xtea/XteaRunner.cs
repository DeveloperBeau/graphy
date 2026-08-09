using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Xtea
{
    public class XteaRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new XteaCipher();
            var vectors = XteaVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
