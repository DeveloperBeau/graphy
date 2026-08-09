using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Adler32
{
    public class Adler32Descriptor : IFamilyDescriptor
    {
        public string Family => "adler32";
        public string Suite => "hash";
        public CipherKind Kind => CipherKind.Hash;

        public ICipher Cipher()
        {
            return new Adler32Cipher();
        }

        public List<TestVector> Vectors()
        {
            return Adler32Vectors.All();
        }
    }
}
