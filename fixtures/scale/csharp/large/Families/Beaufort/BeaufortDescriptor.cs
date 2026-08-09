using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Beaufort
{
    public class BeaufortDescriptor : IFamilyDescriptor
    {
        public string Family => "beaufort";
        public string Suite => "polyalphabetic";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new BeaufortCipher();
        }

        public List<TestVector> Vectors()
        {
            return BeaufortVectors.All();
        }
    }
}
