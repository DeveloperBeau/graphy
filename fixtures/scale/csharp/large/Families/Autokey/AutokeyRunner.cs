using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Autokey
{
    public class AutokeyRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new AutokeyCipher();
            var vectors = AutokeyVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
