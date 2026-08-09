using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.NibbleSwap
{
    public class NibbleSwapDescriptor : IFamilyDescriptor
    {
        public string Family => "nibbleswap";
        public string Suite => "stream";
        public CipherKind Kind => CipherKind.Byte;

        public ICipher Cipher()
        {
            return new NibbleSwapCipher();
        }

        public List<TestVector> Vectors()
        {
            return NibbleSwapVectors.All();
        }
    }
}
