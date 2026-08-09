using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Trithemius
{
    public class TrithemiusRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new TrithemiusCipher();
            var vectors = TrithemiusVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
