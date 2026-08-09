using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Keyword
{
    public class KeywordDescriptor : IFamilyDescriptor
    {
        public string Family => "keyword";
        public string Suite => "classical";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new KeywordCipher();
        }

        public List<TestVector> Vectors()
        {
            return KeywordVectors.All();
        }
    }
}
