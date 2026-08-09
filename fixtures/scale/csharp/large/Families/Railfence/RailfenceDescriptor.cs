using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Railfence
{
    public class RailfenceDescriptor : IFamilyDescriptor
    {
        public string Family => "railfence";
        public string Suite => "transposition";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new RailfenceCipher();
        }

        public List<TestVector> Vectors()
        {
            return RailfenceVectors.All();
        }
    }
}
