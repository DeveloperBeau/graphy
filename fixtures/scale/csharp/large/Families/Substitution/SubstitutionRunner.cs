using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Substitution
{
    public class SubstitutionRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new SubstitutionCipher();
            var vectors = SubstitutionVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
