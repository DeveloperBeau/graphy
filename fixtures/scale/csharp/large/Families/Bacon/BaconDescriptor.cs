using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Bacon
{
    public class BaconDescriptor : IFamilyDescriptor
    {
        public string Family => "bacon";
        public string Suite => "classical";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new BaconCipher();
        }

        public List<TestVector> Vectors()
        {
            return BaconVectors.All();
        }
    }
}
