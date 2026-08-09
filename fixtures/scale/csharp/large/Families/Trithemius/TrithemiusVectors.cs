using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Trithemius
{
    public static class TrithemiusVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "EADNSDWSFFEY"),
                new TestVector("THEQUICKBROWNFOX", "XOODKBYJDWWHBWIU"),
                new TestVector("DEFENDTHEEASTWALL", "HLPRDWPGGJIDHNUIL"),
            };
        }
    }
}
