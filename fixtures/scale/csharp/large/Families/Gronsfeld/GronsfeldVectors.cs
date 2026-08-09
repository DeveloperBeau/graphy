using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Gronsfeld
{
    public static class GronsfeldVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "DYAJNXPKWVTM"),
                new TestVector("THEQUICKBROWNFOX", "WMLZFVRBUMLVOITE"),
                new TestVector("DEFENDTHEEASTWALL", "GJMNYQIYXZXRUZFSU"),
            };
        }
    }
}
