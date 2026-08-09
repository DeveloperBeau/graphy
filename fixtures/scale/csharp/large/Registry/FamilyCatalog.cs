using System.Collections.Generic;
using CipherLab.Abstractions;
using CipherLab.Families.Caesar;
using CipherLab.Families.Rot13;
using CipherLab.Families.Atbash;
using CipherLab.Families.Affine;
using CipherLab.Families.Vigenere;
using CipherLab.Families.Autokey;
using CipherLab.Families.Beaufort;
using CipherLab.Families.Gronsfeld;
using CipherLab.Families.Trithemius;
using CipherLab.Families.Keyword;
using CipherLab.Families.Substitution;
using CipherLab.Families.Railfence;
using CipherLab.Families.Scytale;
using CipherLab.Families.Columnar;
using CipherLab.Families.Polybius;
using CipherLab.Families.Bacon;
using CipherLab.Families.XorStatic;
using CipherLab.Families.XorRolling;
using CipherLab.Families.Rc4;
using CipherLab.Families.LcgStream;
using CipherLab.Families.NibbleSwap;
using CipherLab.Families.RotByte;
using CipherLab.Families.BlockReverse;
using CipherLab.Families.Feistel;
using CipherLab.Families.Tea;
using CipherLab.Families.Xtea;
using CipherLab.Families.Fnv1a32;
using CipherLab.Families.Djb2;
using CipherLab.Families.Sdbm;
using CipherLab.Families.Adler32;
using CipherLab.Families.Crc32;
using CipherLab.Families.Sum16;

namespace CipherLab.Registry
{
    public static class FamilyCatalog
    {
        public static List<IFamilyDescriptor> All()
        {
            return new List<IFamilyDescriptor>
            {
                new CaesarDescriptor(),
                new Rot13Descriptor(),
                new AtbashDescriptor(),
                new AffineDescriptor(),
                new VigenereDescriptor(),
                new AutokeyDescriptor(),
                new BeaufortDescriptor(),
                new GronsfeldDescriptor(),
                new TrithemiusDescriptor(),
                new KeywordDescriptor(),
                new SubstitutionDescriptor(),
                new RailfenceDescriptor(),
                new ScytaleDescriptor(),
                new ColumnarDescriptor(),
                new PolybiusDescriptor(),
                new BaconDescriptor(),
                new XorStaticDescriptor(),
                new XorRollingDescriptor(),
                new Rc4Descriptor(),
                new LcgStreamDescriptor(),
                new NibbleSwapDescriptor(),
                new RotByteDescriptor(),
                new BlockReverseDescriptor(),
                new FeistelDescriptor(),
                new TeaDescriptor(),
                new XteaDescriptor(),
                new Fnv1a32Descriptor(),
                new Djb2Descriptor(),
                new SdbmDescriptor(),
                new Adler32Descriptor(),
                new Crc32Descriptor(),
                new Sum16Descriptor(),
            };
        }
    }
}
