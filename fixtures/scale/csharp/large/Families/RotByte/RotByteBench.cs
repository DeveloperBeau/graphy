using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.RotByte
{
    public class RotByteBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new RotByteCipher();
            var vectors = RotByteVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
