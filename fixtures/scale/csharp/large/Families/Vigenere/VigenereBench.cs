using CipherLab.Abstractions;
using CipherLab.Engine;

namespace CipherLab.Families.Vigenere
{
    public class VigenereBench
    {
        private readonly BenchmarkEngine _engine = new BenchmarkEngine();

        public BenchSample Measure(int iterations)
        {
            var cipher = new VigenereCipher();
            var vectors = VigenereVectors.All();
            return _engine.Sample(cipher, vectors, iterations);
        }
    }
}
