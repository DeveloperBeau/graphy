use crate::core::bytes::rotl32;

/// A cut-down ARX keystream in the Salsa spirit: four words, eight
/// mixing rounds, one 16-byte block per counter value.
fn salsa_lite_block(key: [u32; 4], counter: u32) -> [u8; 16] {
    let mut w = [key[0] ^ counter, key[1], key[2].wrapping_add(counter), key[3]];
    for _ in 0..8 {
        w[0] = w[0].wrapping_add(w[3]) ^ rotl32(w[1], 7);
        w[1] = w[1].wrapping_add(w[0]) ^ rotl32(w[2], 9);
        w[2] = w[2].wrapping_add(w[1]) ^ rotl32(w[3], 13);
        w[3] = w[3].wrapping_add(w[2]) ^ rotl32(w[0], 18);
    }
    let mut block = [0u8; 16];
    for (i, word) in w.iter().enumerate() {
        block[i * 4..i * 4 + 4].copy_from_slice(&word.to_le_bytes());
    }
    block
}

pub fn salsa_lite_encrypt(data: &[u8], key: [u32; 4]) -> Vec<u8> {
    data.chunks(16)
        .enumerate()
        .flat_map(|(n, chunk)| {
            let block = salsa_lite_block(key, n as u32);
            chunk.iter().zip(block).map(|(b, k)| b ^ k).collect::<Vec<u8>>()
        })
        .collect()
}

pub fn salsa_lite_decrypt(data: &[u8], key: [u32; 4]) -> Vec<u8> {
    salsa_lite_encrypt(data, key)
}
