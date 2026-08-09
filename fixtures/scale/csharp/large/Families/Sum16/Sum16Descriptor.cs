using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Sum16
{
    public class Sum16Descriptor : IFamilyDescriptor
    {
        public string Family => "sum16";
        public string Suite => "hash";
        public CipherKind Kind => CipherKind.Hash;

        public ICipher Cipher()
        {
            return new Sum16Cipher();
        }

        public List<TestVector> Vectors()
        {
            return Sum16Vectors.All();
        }
    }
}
