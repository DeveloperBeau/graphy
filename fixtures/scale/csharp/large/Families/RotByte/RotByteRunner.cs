using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.RotByte
{
    public class RotByteRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new RotByteCipher();
            var vectors = RotByteVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
