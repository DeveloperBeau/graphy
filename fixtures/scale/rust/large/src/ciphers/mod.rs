//! One submodule per cipher family; registration lives in the bench registries.

pub mod adler32;
pub mod affine;
pub mod atbash;
pub mod autokey;
pub mod beaufort;
pub mod bifid;
pub mod caesar;
pub mod columnar;
pub mod crc32;
pub mod djb2;
pub mod feistel;
pub mod fnv1a;
pub mod gronsfeld;
pub mod jenkins;
pub mod lcg_stream;
pub mod nihilist;
pub mod pearson;
pub mod polybius;
pub mod porta;
pub mod railfence;
pub mod rc4;
pub mod rot13;
pub mod route;
pub mod salsa_lite;
pub mod scytale;
pub mod sdbm;
pub mod simon;
pub mod speck;
pub mod substitution;
pub mod tea;
pub mod trithemius;
pub mod vigenere;
pub mod xor_stream;
pub mod xtea;

/// Total number of registered families, cross-checked by the registry.
pub const FAMILY_COUNT: usize = 34;
