using System.Collections.Generic;
using System.Diagnostics;
using CipherLab.Abstractions;

namespace CipherLab.Engine
{
    public class BenchmarkEngine
    {
        public BenchSample Sample(ICipher cipher, List<TestVector> vectors, int iterations)
        {
            var watch = Stopwatch.StartNew();
            for (var i = 0; i < iterations; i++)
            {
                foreach (var vector in vectors)
                {
                    cipher.Encode(vector.Plaintext);
                }
            }
            watch.Stop();
            var nanos = watch.Elapsed.Ticks * 100;
            return new BenchSample(cipher.Name, nanos, iterations * vectors.Count);
        }
    }
}
