using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Keyword
{
    public class KeywordBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new KeywordCipher();
            var vectors = KeywordVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
