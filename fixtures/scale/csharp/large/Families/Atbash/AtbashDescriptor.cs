using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Atbash
{
    public class AtbashDescriptor : IFamilyDescriptor
    {
        public string Family => "atbash";
        public string Suite => "classical";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new AtbashCipher();
        }

        public List<TestVector> Vectors()
        {
            return AtbashVectors.All();
        }
    }
}
