using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Vigenere
{
    public class VigenereDescriptor : IFamilyDescriptor
    {
        public string Family => "vigenere";
        public string Suite => "polyalphabetic";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new VigenereCipher();
        }

        public List<TestVector> Vectors()
        {
            return VigenereVectors.All();
        }
    }
}
