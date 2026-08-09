/// Repeating-key XOR; applying it twice restores the input.
pub fn xor_stream_apply(data: &[u8], key: &[u8]) -> Vec<u8> {
    data.iter()
        .enumerate()
        .map(|(i, byte)| byte ^ key[i % key.len()])
        .collect()
}

pub fn xor_stream_encrypt(data: &[u8], key: &[u8]) -> Vec<u8> {
    xor_stream_apply(data, key)
}

pub fn xor_stream_decrypt(data: &[u8], key: &[u8]) -> Vec<u8> {
    xor_stream_apply(data, key)
}
