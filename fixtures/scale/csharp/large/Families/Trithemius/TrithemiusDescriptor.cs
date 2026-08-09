using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Trithemius
{
    public class TrithemiusDescriptor : IFamilyDescriptor
    {
        public string Family => "trithemius";
        public string Suite => "polyalphabetic";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new TrithemiusCipher();
        }

        public List<TestVector> Vectors()
        {
            return TrithemiusVectors.All();
        }
    }
}
