using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Caesar
{
    public static class CaesarVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "DXYGJSJDOMJB"),
                new TestVector("THEQUICKBROWNFOX", "WLJWBQLUMDBKCVFP"),
                new TestVector("DEFENDTHEEASTWALL", "GIKKULCRPQNGIMRDE"),
            };
        }
    }
}
