using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Crc32
{
    public class Crc32Bench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new Crc32Cipher();
            var vectors = Crc32Vectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
