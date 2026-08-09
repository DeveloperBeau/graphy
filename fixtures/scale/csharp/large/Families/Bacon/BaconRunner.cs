using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Bacon
{
    public class BaconRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new BaconCipher();
            var vectors = BaconVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
