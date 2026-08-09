/// Textbook RC4: key-scheduling then the PRGA keystream, XORed in.
pub fn rc4_encrypt(data: &[u8], key: &[u8]) -> Vec<u8> {
    let mut state: Vec<u8> = (0..=255).collect();
    let mut j = 0u8;
    for i in 0..256 {
        j = j.wrapping_add(state[i]).wrapping_add(key[i % key.len()]);
        state.swap(i, j as usize);
    }
    let (mut i, mut j) = (0u8, 0u8);
    data.iter()
        .map(|byte| {
            i = i.wrapping_add(1);
            j = j.wrapping_add(state[i as usize]);
            state.swap(i as usize, j as usize);
            let idx = state[i as usize].wrapping_add(state[j as usize]);
            byte ^ state[idx as usize]
        })
        .collect()
}

pub fn rc4_decrypt(data: &[u8], key: &[u8]) -> Vec<u8> {
    rc4_encrypt(data, key)
}
