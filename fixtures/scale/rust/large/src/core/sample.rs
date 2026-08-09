use crate::core::rng::XorShift32;

/// Shared verification corpus. It deliberately avoids the letter J so
/// the 25-cell grid families (polybius, bifid, nihilist) round-trip
/// exactly, and it does not end in X so padded transposition output
/// can be trimmed safely.
const CORPUS: &str = "THE QUICK BROWN FOX VAULTS OVER THE LAZY DOG WHILE FIVE \
BOXING WIZARDS WATCH FROM THE OLD STONE WALL NEAR THE HARBOR";

/// 25-letter alphabet used when generating bench text (no J, same
/// reason as above).
const LETTERS: &[u8; 25] = b"ABCDEFGHIKLMNOPQRSTUVWXYZ";

pub fn sample_text() -> &'static str {
    CORPUS
}

pub fn sample_ascii(len: usize) -> String {
    let mut rng = XorShift32::new(len as u32 ^ 0xA5A5_5A5A);
    (0..len)
        .map(|_| LETTERS[(rng.next_u32() as usize) % LETTERS.len()] as char)
        .collect()
}

pub fn sample_bytes(len: usize) -> Vec<u8> {
    XorShift32::new(len as u32 | 1).fill(len)
}
