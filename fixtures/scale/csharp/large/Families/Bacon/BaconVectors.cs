using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Bacon
{
    public static class BaconVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "EYZHKTKEPNKC"),
                new TestVector("THEQUICKBROWNFOX", "XMKXCRMVNECLDWGQ"),
                new TestVector("DEFENDTHEEASTWALL", "HJLLVMDSQROHJNSEF"),
            };
        }
    }
}
