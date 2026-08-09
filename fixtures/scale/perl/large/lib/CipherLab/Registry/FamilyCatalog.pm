package CipherLab::Registry::FamilyCatalog;
use strict;
use warnings;
use CipherLab::Families::Caesar::CaesarDescriptor;
use CipherLab::Families::Rot13::Rot13Descriptor;
use CipherLab::Families::Atbash::AtbashDescriptor;
use CipherLab::Families::Affine::AffineDescriptor;
use CipherLab::Families::Vigenere::VigenereDescriptor;
use CipherLab::Families::Autokey::AutokeyDescriptor;
use CipherLab::Families::Beaufort::BeaufortDescriptor;
use CipherLab::Families::Gronsfeld::GronsfeldDescriptor;
use CipherLab::Families::Trithemius::TrithemiusDescriptor;
use CipherLab::Families::Keyword::KeywordDescriptor;
use CipherLab::Families::Substitution::SubstitutionDescriptor;
use CipherLab::Families::Railfence::RailfenceDescriptor;
use CipherLab::Families::Scytale::ScytaleDescriptor;
use CipherLab::Families::Columnar::ColumnarDescriptor;
use CipherLab::Families::Polybius::PolybiusDescriptor;
use CipherLab::Families::Bacon::BaconDescriptor;
use CipherLab::Families::XorStatic::XorStaticDescriptor;
use CipherLab::Families::XorRolling::XorRollingDescriptor;
use CipherLab::Families::Rc4::Rc4Descriptor;
use CipherLab::Families::LcgStream::LcgStreamDescriptor;
use CipherLab::Families::NibbleSwap::NibbleSwapDescriptor;
use CipherLab::Families::RotByte::RotByteDescriptor;
use CipherLab::Families::BlockReverse::BlockReverseDescriptor;
use CipherLab::Families::Feistel::FeistelDescriptor;
use CipherLab::Families::Tea::TeaDescriptor;
use CipherLab::Families::Xtea::XteaDescriptor;
use CipherLab::Families::Fnv1a32::Fnv1a32Descriptor;
use CipherLab::Families::Djb2::Djb2Descriptor;
use CipherLab::Families::Sdbm::SdbmDescriptor;
use CipherLab::Families::Adler32::Adler32Descriptor;
use CipherLab::Families::Crc32::Crc32Descriptor;
use CipherLab::Families::Sum16::Sum16Descriptor;

sub all {
    return (
        CipherLab::Families::Caesar::CaesarDescriptor->new,
        CipherLab::Families::Rot13::Rot13Descriptor->new,
        CipherLab::Families::Atbash::AtbashDescriptor->new,
        CipherLab::Families::Affine::AffineDescriptor->new,
        CipherLab::Families::Vigenere::VigenereDescriptor->new,
        CipherLab::Families::Autokey::AutokeyDescriptor->new,
        CipherLab::Families::Beaufort::BeaufortDescriptor->new,
        CipherLab::Families::Gronsfeld::GronsfeldDescriptor->new,
        CipherLab::Families::Trithemius::TrithemiusDescriptor->new,
        CipherLab::Families::Keyword::KeywordDescriptor->new,
        CipherLab::Families::Substitution::SubstitutionDescriptor->new,
        CipherLab::Families::Railfence::RailfenceDescriptor->new,
        CipherLab::Families::Scytale::ScytaleDescriptor->new,
        CipherLab::Families::Columnar::ColumnarDescriptor->new,
        CipherLab::Families::Polybius::PolybiusDescriptor->new,
        CipherLab::Families::Bacon::BaconDescriptor->new,
        CipherLab::Families::XorStatic::XorStaticDescriptor->new,
        CipherLab::Families::XorRolling::XorRollingDescriptor->new,
        CipherLab::Families::Rc4::Rc4Descriptor->new,
        CipherLab::Families::LcgStream::LcgStreamDescriptor->new,
        CipherLab::Families::NibbleSwap::NibbleSwapDescriptor->new,
        CipherLab::Families::RotByte::RotByteDescriptor->new,
        CipherLab::Families::BlockReverse::BlockReverseDescriptor->new,
        CipherLab::Families::Feistel::FeistelDescriptor->new,
        CipherLab::Families::Tea::TeaDescriptor->new,
        CipherLab::Families::Xtea::XteaDescriptor->new,
        CipherLab::Families::Fnv1a32::Fnv1a32Descriptor->new,
        CipherLab::Families::Djb2::Djb2Descriptor->new,
        CipherLab::Families::Sdbm::SdbmDescriptor->new,
        CipherLab::Families::Adler32::Adler32Descriptor->new,
        CipherLab::Families::Crc32::Crc32Descriptor->new,
        CipherLab::Families::Sum16::Sum16Descriptor->new,
    );
}

1;
