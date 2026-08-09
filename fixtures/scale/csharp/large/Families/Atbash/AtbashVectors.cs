using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Atbash
{
    public static class AtbashVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("ATTACKATDAWN", "FBEOTEXTGGFZ"),
                new TestVector("THEQUICKBROWNFOX", "YPPELCZKEXXICXJV"),
                new TestVector("DEFENDTHEEASTWALL", "IMQSEXQHHKJEIOVJM"),
            };
        }
    }
}
