using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Autokey
{
    public class AutokeyDescriptor : IFamilyDescriptor
    {
        public string Family => "autokey";
        public string Suite => "polyalphabetic";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new AutokeyCipher();
        }

        public List<TestVector> Vectors()
        {
            return AutokeyVectors.All();
        }
    }
}
