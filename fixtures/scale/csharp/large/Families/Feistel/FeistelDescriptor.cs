using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Feistel
{
    public class FeistelDescriptor : IFamilyDescriptor
    {
        public string Family => "feistel";
        public string Suite => "block";
        public CipherKind Kind => CipherKind.Block;

        public ICipher Cipher()
        {
            return new FeistelCipher();
        }

        public List<TestVector> Vectors()
        {
            return FeistelVectors.All();
        }
    }
}
