using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.LcgStream
{
    public class LcgStreamDescriptor : IFamilyDescriptor
    {
        public string Family => "lcgstream";
        public string Suite => "stream";
        public CipherKind Kind => CipherKind.Byte;

        public ICipher Cipher()
        {
            return new LcgStreamCipher();
        }

        public List<TestVector> Vectors()
        {
            return LcgStreamVectors.All();
        }
    }
}
