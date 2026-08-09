using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Columnar
{
    public class ColumnarBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new ColumnarCipher();
            var vectors = ColumnarVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
