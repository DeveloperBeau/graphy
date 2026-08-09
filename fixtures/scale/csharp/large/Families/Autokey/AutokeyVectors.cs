using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Autokey
{
    public static class AutokeyVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "IEHRWHAWJJIC"),
                new TestVector("THEQUICKBROWNFOX", "BSSHOFCNHAALFAMY"),
                new TestVector("DEFENDTHEEASTWALL", "LPTVHATKKNMHLRYMP"),
            };
        }
    }
}
