using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Adler32
{
    public class Adler32Bench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new Adler32Cipher();
            var vectors = Adler32Vectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
