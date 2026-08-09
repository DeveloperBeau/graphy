using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Polybius
{
    public class PolybiusDescriptor : IFamilyDescriptor
    {
        public string Family => "polybius";
        public string Suite => "classical";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new PolybiusCipher();
        }

        public List<TestVector> Vectors()
        {
            return PolybiusVectors.All();
        }
    }
}
