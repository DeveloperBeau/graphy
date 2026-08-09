using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Polybius
{
    public static class PolybiusVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "DZCMRCVREEDX"),
                new TestVector("THEQUICKBROWNFOX", "WNNCJAXICVVGAVHT"),
                new TestVector("DEFENDTHEEASTWALL", "GKOQCVOFFIHCGMTHK"),
            };
        }
    }
}
