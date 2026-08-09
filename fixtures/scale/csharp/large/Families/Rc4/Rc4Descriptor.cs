using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Rc4
{
    public class Rc4Descriptor : IFamilyDescriptor
    {
        public string Family => "rc4";
        public string Suite => "stream";
        public CipherKind Kind => CipherKind.Byte;

        public ICipher Cipher()
        {
            return new Rc4Cipher();
        }

        public List<TestVector> Vectors()
        {
            return Rc4Vectors.All();
        }
    }
}
