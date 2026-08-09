use crate::core::bytes::{blocks_to_bytes, bytes_to_blocks, rotl32};

fn simon_schedule(key: [u32; 4]) -> Vec<u32> {
    let mut ks: Vec<u32> = key.to_vec();
    for i in 4..32 {
        let tmp = rotl32(ks[i - 1], 29) ^ ks[i - 3];
        ks.push(!ks[i - 4] ^ tmp ^ rotl32(tmp, 31) ^ (0x1u32 << (i % 2)) ^ 3);
    }
    ks
}

fn simon_mix(x: u32) -> u32 {
    (rotl32(x, 1) & rotl32(x, 8)) ^ rotl32(x, 2)
}
pub fn simon_encrypt(data: &[u8], key: [u32; 4]) -> Vec<u8> {
    let ks = simon_schedule(key);
    let blocks = bytes_to_blocks(data).iter().map(|&(mut x, mut y)| {
        for k in ks.iter() {
            let next = y ^ simon_mix(x) ^ k;
            y = x;
            x = next;
        }
        (x, y)
    }).collect::<Vec<_>>();
    blocks_to_bytes(&blocks)
}

pub fn simon_decrypt(data: &[u8], key: [u32; 4]) -> Vec<u8> {
    let ks = simon_schedule(key);
    let blocks = bytes_to_blocks(data).iter().map(|&(mut x, mut y)| {
        for k in ks.iter().rev() {
            let prev = x ^ simon_mix(y) ^ k;
            x = y;
            y = prev;
        }
        (x, y)
    }).collect::<Vec<_>>();
    blocks_to_bytes(&blocks)
}
