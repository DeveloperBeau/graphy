using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.XorStatic
{
    public class XorStaticDescriptor : IFamilyDescriptor
    {
        public string Family => "xorstatic";
        public string Suite => "stream";
        public CipherKind Kind => CipherKind.Byte;

        public ICipher Cipher()
        {
            return new XorStaticCipher();
        }

        public List<TestVector> Vectors()
        {
            return XorStaticVectors.All();
        }
    }
}
