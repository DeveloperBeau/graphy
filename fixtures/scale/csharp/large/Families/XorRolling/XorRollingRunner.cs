using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.XorRolling
{
    public class XorRollingRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new XorRollingCipher();
            var vectors = XorRollingVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
