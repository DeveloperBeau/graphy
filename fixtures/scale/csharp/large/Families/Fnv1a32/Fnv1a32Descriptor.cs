using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Fnv1a32
{
    public class Fnv1a32Descriptor : IFamilyDescriptor
    {
        public string Family => "fnv1a32";
        public string Suite => "hash";
        public CipherKind Kind => CipherKind.Hash;

        public ICipher Cipher()
        {
            return new Fnv1a32Cipher();
        }

        public List<TestVector> Vectors()
        {
            return Fnv1a32Vectors.All();
        }
    }
}
