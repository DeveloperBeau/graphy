using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Railfence
{
    public static class RailfenceVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "HDGQVGZVIIHB"),
                new TestVector("THEQUICKBROWNFOX", "ARRGNEBMGZZKEZLX"),
                new TestVector("DEFENDTHEEASTWALL", "KOSUGZSJJMLGKQXLO"),
            };
        }
    }
}
