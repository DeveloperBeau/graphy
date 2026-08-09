pub fn rotl32(x: u32, n: u32) -> u32 {
    x.rotate_left(n % 32)
}

pub fn rotr32(x: u32, n: u32) -> u32 {
    x.rotate_right(n % 32)
}

/// Pack bytes into little-endian u32 pairs, zero-padding the tail so
/// every 8-byte block cipher sees whole blocks.
pub fn bytes_to_blocks(data: &[u8]) -> Vec<(u32, u32)> {
    data.chunks(8)
        .map(|chunk| {
            let mut buf = [0u8; 8];
            buf[..chunk.len()].copy_from_slice(chunk);
            let lo = u32::from_le_bytes(buf[0..4].try_into().expect("4 bytes"));
            let hi = u32::from_le_bytes(buf[4..8].try_into().expect("4 bytes"));
            (lo, hi)
        })
        .collect()
}

pub fn blocks_to_bytes(blocks: &[(u32, u32)]) -> Vec<u8> {
    let mut out = Vec::with_capacity(blocks.len() * 8);
    for &(lo, hi) in blocks {
        out.extend_from_slice(&lo.to_le_bytes());
        out.extend_from_slice(&hi.to_le_bytes());
    }
    out
}
