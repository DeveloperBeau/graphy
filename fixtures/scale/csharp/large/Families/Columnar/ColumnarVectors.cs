using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Columnar
{
    public static class ColumnarVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "JEGPTDVQCBZS"),
                new TestVector("THEQUICKBROWNFOX", "CSRFLBXHASRBUOZK"),
                new TestVector("DEFENDTHEEASTWALL", "MPSTEWOEDFDXAFLYA"),
            };
        }
    }
}
