/// Keystream drawn from a linear congruential generator's high byte.
pub fn lcg_stream_encrypt(data: &[u8], seed: u32) -> Vec<u8> {
    let mut state = seed;
    data.iter()
        .map(|byte| {
            state = state.wrapping_mul(1_664_525).wrapping_add(1_013_904_223);
            byte ^ (state >> 24) as u8
        })
        .collect()
}

pub fn lcg_stream_decrypt(data: &[u8], seed: u32) -> Vec<u8> {
    lcg_stream_encrypt(data, seed)
}
