using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Affine
{
    public class AffineRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new AffineCipher();
            var vectors = AffineVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
