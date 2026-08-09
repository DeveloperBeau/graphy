use crate::core::bytes::{blocks_to_bytes, bytes_to_blocks};

const DELTA: u32 = 0x9E37_79B9;

pub fn xtea_encrypt(data: &[u8], key: [u32; 4]) -> Vec<u8> {
    let blocks = bytes_to_blocks(data).iter().map(|&(mut v0, mut v1)| {
        let mut sum = 0u32;
        for _ in 0..32 {
            v0 = v0.wrapping_add((((v1 << 4) ^ (v1 >> 5)).wrapping_add(v1)) ^ sum.wrapping_add(key[(sum & 3) as usize]));
            sum = sum.wrapping_add(DELTA);
            v1 = v1.wrapping_add((((v0 << 4) ^ (v0 >> 5)).wrapping_add(v0)) ^ sum.wrapping_add(key[((sum >> 11) & 3) as usize]));
        }
        (v0, v1)
    }).collect::<Vec<_>>();
    blocks_to_bytes(&blocks)
}

pub fn xtea_decrypt(data: &[u8], key: [u32; 4]) -> Vec<u8> {
    let blocks = bytes_to_blocks(data).iter().map(|&(mut v0, mut v1)| {
        let mut sum = DELTA.wrapping_mul(32);
        for _ in 0..32 {
            v1 = v1.wrapping_sub((((v0 << 4) ^ (v0 >> 5)).wrapping_add(v0)) ^ sum.wrapping_add(key[((sum >> 11) & 3) as usize]));
            sum = sum.wrapping_sub(DELTA);
            v0 = v0.wrapping_sub((((v1 << 4) ^ (v1 >> 5)).wrapping_add(v1)) ^ sum.wrapping_add(key[(sum & 3) as usize]));
        }
        (v0, v1)
    }).collect::<Vec<_>>();
    blocks_to_bytes(&blocks)
}
