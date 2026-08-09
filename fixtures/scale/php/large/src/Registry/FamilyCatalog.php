<?php

namespace CipherLab\Registry;

use CipherLab\Families\Caesar\CaesarDescriptor;
use CipherLab\Families\Rot13\Rot13Descriptor;
use CipherLab\Families\Atbash\AtbashDescriptor;
use CipherLab\Families\Affine\AffineDescriptor;
use CipherLab\Families\Vigenere\VigenereDescriptor;
use CipherLab\Families\Autokey\AutokeyDescriptor;
use CipherLab\Families\Beaufort\BeaufortDescriptor;
use CipherLab\Families\Gronsfeld\GronsfeldDescriptor;
use CipherLab\Families\Trithemius\TrithemiusDescriptor;
use CipherLab\Families\Keyword\KeywordDescriptor;
use CipherLab\Families\Substitution\SubstitutionDescriptor;
use CipherLab\Families\Railfence\RailfenceDescriptor;
use CipherLab\Families\Scytale\ScytaleDescriptor;
use CipherLab\Families\Columnar\ColumnarDescriptor;
use CipherLab\Families\Polybius\PolybiusDescriptor;
use CipherLab\Families\Bacon\BaconDescriptor;
use CipherLab\Families\XorStatic\XorStaticDescriptor;
use CipherLab\Families\XorRolling\XorRollingDescriptor;
use CipherLab\Families\Rc4\Rc4Descriptor;
use CipherLab\Families\LcgStream\LcgStreamDescriptor;
use CipherLab\Families\NibbleSwap\NibbleSwapDescriptor;
use CipherLab\Families\RotByte\RotByteDescriptor;
use CipherLab\Families\BlockReverse\BlockReverseDescriptor;
use CipherLab\Families\Feistel\FeistelDescriptor;
use CipherLab\Families\Tea\TeaDescriptor;
use CipherLab\Families\Xtea\XteaDescriptor;
use CipherLab\Families\Fnv1a32\Fnv1a32Descriptor;
use CipherLab\Families\Djb2\Djb2Descriptor;
use CipherLab\Families\Sdbm\SdbmDescriptor;
use CipherLab\Families\Adler32\Adler32Descriptor;
use CipherLab\Families\Crc32\Crc32Descriptor;
use CipherLab\Families\Sum16\Sum16Descriptor;

class FamilyCatalog
{
    /** @return \CipherLab\Abstractions\FamilyDescriptor[] */
    public static function all(): array
    {
        return [
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
        ];
    }
}
