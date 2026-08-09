using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Djb2
{
    public static class Djb2Vectors
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
