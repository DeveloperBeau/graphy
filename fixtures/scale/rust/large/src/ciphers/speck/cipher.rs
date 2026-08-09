use crate::core::bytes::{blocks_to_bytes, bytes_to_blocks, rotl32, rotr32};

const ROUNDS: u32 = 27;

fn speck_schedule(key: [u32; 4]) -> Vec<u32> {
    let mut ks = vec![key[0]];
    let mut l = [key[1], key[2], key[3]];
    for i in 0..ROUNDS - 1 {
        let li = rotr32(l[(i % 3) as usize], 8).wrapping_add(ks[i as usize]) ^ i;
        l[(i % 3) as usize] = li;
        ks.push(rotl32(ks[i as usize], 3) ^ li);
    }
    ks
}

pub fn speck_encrypt(data: &[u8], key: [u32; 4]) -> Vec<u8> {
    let ks = speck_schedule(key);
    let blocks = bytes_to_blocks(data).iter().map(|&(mut x, mut y)| {
        for &k in &ks {
            x = rotr32(x, 8).wrapping_add(y) ^ k;
            y = rotl32(y, 3) ^ x;
        }
        (x, y)
    }).collect::<Vec<_>>();
    blocks_to_bytes(&blocks)
}

pub fn speck_decrypt(data: &[u8], key: [u32; 4]) -> Vec<u8> {
    let ks = speck_schedule(key);
    let blocks = bytes_to_blocks(data).iter().map(|&(mut x, mut y)| {
        for &k in ks.iter().rev() {
            y = rotr32(y ^ x, 3);
            x = rotl32((x ^ k).wrapping_sub(y), 8);
        }
        (x, y)
    }).collect::<Vec<_>>();
    blocks_to_bytes(&blocks)
}
