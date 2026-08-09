using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Rot13
{
    public static class Rot13Vectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "EZBKOYQLXWUN"),
                new TestVector("THEQUICKBROWNFOX", "XNMAGWSCVNMWPJUF"),
                new TestVector("DEFENDTHEEASTWALL", "HKNOZRJZYAYSVAGTV"),
            };
        }
    }
}
