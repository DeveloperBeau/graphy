using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.NibbleSwap
{
    public static class NibbleSwapVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("The quick brown fox jumps ov", "5d626e2c7c7b66737a3271667a6179387f75633c776b725052024c52"),
                new TestVector("cipher test corpus", "6a637b64687c2f6474616734767965686c69"),
                new TestVector("0123456789abcdef", "393b393f393b3927292b72767672727e"),
            };
        }
    }
}
