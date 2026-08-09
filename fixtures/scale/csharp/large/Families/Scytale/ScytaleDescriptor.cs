using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Scytale
{
    public class ScytaleDescriptor : IFamilyDescriptor
    {
        public string Family => "scytale";
        public string Suite => "transposition";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new ScytaleCipher();
        }

        public List<TestVector> Vectors()
        {
            return ScytaleVectors.All();
        }
    }
}
