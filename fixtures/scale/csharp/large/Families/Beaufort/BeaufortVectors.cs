using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Beaufort
{
    public static class BeaufortVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "JDEMPYPJUSPH"),
                new TestVector("THEQUICKBROWNFOX", "CRPCHWRASJHQIBLV"),
                new TestVector("DEFENDTHEEASTWALL", "MOQQARIXVWTMOSXJK"),
            };
        }
    }
}
