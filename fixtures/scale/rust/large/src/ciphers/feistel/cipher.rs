use crate::core::bytes::{blocks_to_bytes, bytes_to_blocks, rotl32};

const ROUNDS: usize = 16;

fn feistel_round(half: u32, subkey: u32) -> u32 {
    rotl32(half, 4).wrapping_add(subkey) ^ (half >> 5) ^ subkey.wrapping_mul(0x9E37)
}

fn feistel_subkeys(key: u32) -> Vec<u32> {
    (0..ROUNDS as u32)
        .map(|i| key.wrapping_mul(i.wrapping_add(0x1234_5677)) ^ rotl32(key, i % 31))
        .collect()
}

pub fn feistel_encrypt(data: &[u8], key: u32) -> Vec<u8> {
    let subkeys = feistel_subkeys(key);
    let blocks = bytes_to_blocks(data).iter().map(|&(mut left, mut right)| {
        for &sk in &subkeys {
            let next = left ^ feistel_round(right, sk);
            left = right;
            right = next;
        }
        (right, left)
    }).collect::<Vec<_>>();
    blocks_to_bytes(&blocks)
}

pub fn feistel_decrypt(data: &[u8], key: u32) -> Vec<u8> {
    let mut subkeys = feistel_subkeys(key);
    subkeys.reverse();
    let blocks = bytes_to_blocks(data).iter().map(|&(mut left, mut right)| {
        for &sk in &subkeys {
            let next = left ^ feistel_round(right, sk);
            left = right;
            right = next;
        }
        (right, left)
    }).collect::<Vec<_>>();
    blocks_to_bytes(&blocks)
}
