using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.XorRolling
{
    public class XorRollingDescriptor : IFamilyDescriptor
    {
        public string Family => "xorrolling";
        public string Suite => "stream";
        public CipherKind Kind => CipherKind.Byte;

        public ICipher Cipher()
        {
            return new XorRollingCipher();
        }

        public List<TestVector> Vectors()
        {
            return XorRollingVectors.All();
        }
    }
}
