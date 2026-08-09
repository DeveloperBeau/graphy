using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Djb2
{
    public class Djb2Descriptor : IFamilyDescriptor
    {
        public string Family => "djb2";
        public string Suite => "hash";
        public CipherKind Kind => CipherKind.Hash;

        public ICipher Cipher()
        {
            return new Djb2Cipher();
        }

        public List<TestVector> Vectors()
        {
            return Djb2Vectors.All();
        }
    }
}
