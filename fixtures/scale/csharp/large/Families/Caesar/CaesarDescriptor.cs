using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Caesar
{
    public class CaesarDescriptor : IFamilyDescriptor
    {
        public string Family => "caesar";
        public string Suite => "classical";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new CaesarCipher();
        }

        public List<TestVector> Vectors()
        {
            return CaesarVectors.All();
        }
    }
}
