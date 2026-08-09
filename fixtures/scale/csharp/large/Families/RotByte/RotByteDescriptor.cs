using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.RotByte
{
    public class RotByteDescriptor : IFamilyDescriptor
    {
        public string Family => "rotbyte";
        public string Suite => "stream";
        public CipherKind Kind => CipherKind.Byte;

        public ICipher Cipher()
        {
            return new RotByteCipher();
        }

        public List<TestVector> Vectors()
        {
            return RotByteVectors.All();
        }
    }
}
