using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Rc4
{
    public static class Rc4Vectors
    {
        public static List<TestVector> All()
        {
            return new List<TestVector>
            {
                new TestVector("The quick brown fox jumps ov", "53606c2a7a79646d643073607c637b367177613a7169706e6c004e54"),
                new TestVector("cipher test corpus", "646179626e7e2d7a6a636532707b6766626b"),
                new TestVector("0123456789abcdef", "37393b393f393b393729707070707070"),
            };
        }
    }
}
