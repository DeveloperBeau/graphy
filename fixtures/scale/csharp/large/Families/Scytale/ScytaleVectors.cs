using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Scytale
{
    public static class ScytaleVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "ICDLOXOITROG"),
                new TestVector("THEQUICKBROWNFOX", "BQOBGVQZRIGPHAKU"),
                new TestVector("DEFENDTHEEASTWALL", "LNPPZQHWUVSLNRWIJ"),
            };
        }
    }
}
