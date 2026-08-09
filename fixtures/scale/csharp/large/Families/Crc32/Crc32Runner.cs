using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Crc32
{
    public class Crc32Runner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new Crc32Cipher();
            var vectors = Crc32Vectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
