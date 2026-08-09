using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Polybius
{
    public class PolybiusRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new PolybiusCipher();
            var vectors = PolybiusVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
