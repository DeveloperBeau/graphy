using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Substitution
{
    public static class SubstitutionVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "GBDMQASNZYWP"),
                new TestVector("THEQUICKBROWNFOX", "ZPOCIYUEXPOYRLWH"),
                new TestVector("DEFENDTHEEASTWALL", "JMPQBTLBACAUXCIVX"),
            };
        }
    }
}
