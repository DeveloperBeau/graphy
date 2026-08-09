using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.XorStatic
{
    public class XorStaticRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new XorStaticCipher();
            var vectors = XorStaticVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
