using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Tea
{
    public static class TeaVectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("The quick brown!", "a8d0ca40e2ead2c6d640c4e4deeedc42"),
                new TestVector("0123456789abcdef", "60626466686a6c6e7072c2c4c6c8cacc"),
                new TestVector("silver marble owl padloc", "e6d2d8eccae440dac2e4c4d8ca40deeed840e0c2c8d8dec6"),
            };
        }
    }
}
