using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Xtea
{
    public static class XteaVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("The quick brown!", "51a19580c5d5a58dad8089c9bdddb984"),
                new TestVector("0123456789abcdef", "c0c4c8ccd0d4d8dce0e485898d919599"),
                new TestVector("silver marble owl padloc", "cda5b1d995c980b585c989b19580bdddb180c18591b1bd8d"),
            };
        }
    }
}
