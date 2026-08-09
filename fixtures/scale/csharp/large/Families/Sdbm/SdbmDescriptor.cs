using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Sdbm
{
    public class SdbmDescriptor : IFamilyDescriptor
    {
        public string Family => "sdbm";
        public string Suite => "hash";
        public CipherKind Kind => CipherKind.Hash;

        public ICipher Cipher()
        {
            return new SdbmCipher();
        }

        public List<TestVector> Vectors()
        {
            return SdbmVectors.All();
        }
    }
}
