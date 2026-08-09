using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Fnv1a32
{
    public static class Fnv1a32Vectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("abc", "1a47e90b"),
                new TestVector("hello world", "d58b3fa7"),
                new TestVector("The quick brown fox jumps over the lazy dog", "048fff90"),
            };
        }
    }
}
