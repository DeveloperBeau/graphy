using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Rc4
{
    public class Rc4Bench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new Rc4Cipher();
            var vectors = Rc4Vectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
