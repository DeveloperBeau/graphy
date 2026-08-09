using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Sdbm
{
    public class SdbmRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new SdbmCipher();
            var vectors = SdbmVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
