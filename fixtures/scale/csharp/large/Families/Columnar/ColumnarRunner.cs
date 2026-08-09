using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Columnar
{
    public class ColumnarRunner
    {
        private readonly CorrectnessEngine _engine = new CorrectnessEngine();

        public VectorOutcome Check()
        {
            var cipher = new ColumnarCipher();
            var vectors = ColumnarVectors.All();
            return _engine.Verify(cipher, vectors);
        }
    }
}
