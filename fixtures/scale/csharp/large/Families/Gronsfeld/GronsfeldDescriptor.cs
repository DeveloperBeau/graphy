using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Gronsfeld
{
    public class GronsfeldDescriptor : IFamilyDescriptor
    {
        public string Family => "gronsfeld";
        public string Suite => "polyalphabetic";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new GronsfeldCipher();
        }

        public List<TestVector> Vectors()
        {
            return GronsfeldVectors.All();
        }
    }
}
