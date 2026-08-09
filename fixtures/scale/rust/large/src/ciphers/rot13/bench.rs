use crate::ciphers::rot13::cipher::rot13_encrypt;
use crate::ciphers::rot13::keys::rot13_default_key;
use crate::core::sample::sample_ascii;
use crate::core::timer::Stopwatch;

/// Time one encryption pass over `input_len` generated letters.
pub fn rot13_measure(input_len: usize) -> u128 {
    let data = sample_ascii(input_len);
    let key = rot13_default_key();
    let watch = Stopwatch::start();
    let sealed = rot13_encrypt(&data, key);
    std::hint::black_box(sealed.len());
    watch.elapsed_ns()
}
