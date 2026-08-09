using System.Collections.Generic;
using CipherLab.Abstractions;

namespace CipherLab.Families.BlockReverse
{
    public class BlockReverseDescriptor : IFamilyDescriptor
    {
        public string Family => "blockreverse";
        public string Suite => "block";
        public CipherKind Kind => CipherKind.Block;

        public ICipher Cipher()
        {
            return new BlockReverseCipher();
        }

        public List<TestVector> Vectors()
        {
            return BlockReverseVectors.All();
        }
    }
}
