using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Xtea
{
    public class XteaDescriptor : IFamilyDescriptor
    {
        public string Family => "xtea";
        public string Suite => "block";
        public CipherKind Kind => CipherKind.Block;

        public ICipher Cipher()
        {
            return new XteaCipher();
        }

        public List<TestVector> Vectors()
        {
            return XteaVectors.All();
        }
    }
}
