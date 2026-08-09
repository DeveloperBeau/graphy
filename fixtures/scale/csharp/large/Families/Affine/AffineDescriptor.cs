using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Affine
{
    public class AffineDescriptor : IFamilyDescriptor
    {
        public string Family => "affine";
        public string Suite => "classical";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new AffineCipher();
        }

        public List<TestVector> Vectors()
        {
            return AffineVectors.All();
        }
    }
}
