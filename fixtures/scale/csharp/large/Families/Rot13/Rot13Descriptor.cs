using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Rot13
{
    public class Rot13Descriptor : IFamilyDescriptor
    {
        public string Family => "rot13";
        public string Suite => "classical";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new Rot13Cipher();
        }

        public List<TestVector> Vectors()
        {
            return Rot13Vectors.All();
        }
    }
}
