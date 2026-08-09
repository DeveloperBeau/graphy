using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.LcgStream
{
    public static class LcgStreamVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("The quick brown fox jumps ov", "5c616f2b7d78676c7b3170617b6278377e76623b7668736f53014d55"),
                new TestVector("cipher test corpus", "6b607a63697f2e7b75626633777a64676d6a"),
                new TestVector("0123456789abcdef", "38383838383838382828737177717371"),
            };
        }
    }
}
