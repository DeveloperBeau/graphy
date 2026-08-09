use crate::ciphers::polybius::cipher::polybius_encrypt;
use crate::ciphers::polybius::keys::polybius_default_key;
use crate::core::sample::sample_ascii;
use crate::core::timer::Stopwatch;

/// Time one encryption pass over `input_len` generated letters.
pub fn polybius_measure(input_len: usize) -> u128 {
    let data = sample_ascii(input_len);
    let key = polybius_default_key();
    let watch = Stopwatch::start();
    let sealed = polybius_encrypt(&data, key);
    std::hint::black_box(sealed.len());
    watch.elapsed_ns()
}
