using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.Substitution
{
    public class SubstitutionDescriptor : IFamilyDescriptor
    {
        public string Family => "substitution";
        public string Suite => "classical";
        public CipherKind Kind => CipherKind.Letter;

        public ICipher Cipher()
        {
            return new SubstitutionCipher();
        }

        public List<TestVector> Vectors()
        {
            return SubstitutionVectors.All();
        }
    }
}
