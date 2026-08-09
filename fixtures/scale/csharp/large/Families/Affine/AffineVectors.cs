using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Affine
{
    public static class AffineVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "GABJMVMGRPME"),
                new TestVector("THEQUICKBROWNFOX", "ZOMZETOXPGENFYIS"),
                new TestVector("DEFENDTHEEASTWALL", "JLNNXOFUSTQJLPUGH"),
            };
        }
    }
}
