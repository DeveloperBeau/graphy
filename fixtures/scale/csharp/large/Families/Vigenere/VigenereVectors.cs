using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Vigenere
{
    public static class VigenereVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "HCENRBTOAZXQ"),
                new TestVector("THEQUICKBROWNFOX", "AQPDJZVFYQPZSMXI"),
                new TestVector("DEFENDTHEEASTWALL", "KNQRCUMCBDBVYDJWY"),
            };
        }
    }
}
