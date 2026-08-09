using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Keyword
{
    public static class KeywordVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "FZAILULFQOLD"),
                new TestVector("THEQUICKBROWNFOX", "YNLYDSNWOFDMEXHR"),
                new TestVector("DEFENDTHEEASTWALL", "IKMMWNETRSPIKOTFG"),
            };
        }
    }
}
