using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Columnar
{
    public class ColumnarDescriptor : IFamilyDescriptor
    {
        public string Family => "columnar";
        public string Suite => "transposition";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new ColumnarCipher();
        }

        public List<TestVector> Vectors()
        {
            return ColumnarVectors.All();
        }
    }
}
