using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Tea
{
    public class TeaDescriptor : IFamilyDescriptor
    {
        public string Family => "tea";
        public string Suite => "block";
        public CipherKind Kind => CipherKind.Block;

        public ICipher Cipher()
        {
            return new TeaCipher();
        }

        public List<TestVector> Vectors()
        {
            return TeaVectors.All();
        }
    }
}
