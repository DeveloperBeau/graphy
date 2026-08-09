using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Crc32
{
    public class Crc32Descriptor : IFamilyDescriptor
    {
        public string Family => "crc32";
        public string Suite => "hash";
        public CipherKind Kind => CipherKind.Hash;

        public ICipher Cipher()
        {
            return new Crc32Cipher();
        }

        public List<TestVector> Vectors()
        {
            return Crc32Vectors.All();
        }
    }
}
