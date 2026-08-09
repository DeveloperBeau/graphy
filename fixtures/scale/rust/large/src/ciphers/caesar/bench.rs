use crate::ciphers::caesar::cipher::caesar_encrypt;
use crate::ciphers::caesar::keys::caesar_default_key;
use crate::core::sample::sample_ascii;
use crate::core::timer::Stopwatch;

/// Time one encryption pass over `input_len` generated letters.
pub fn caesar_measure(input_len: usize) -> u128 {
    let data = sample_ascii(input_len);
    let key = caesar_default_key();
    let watch = Stopwatch::start();
    let sealed = caesar_encrypt(&data, key);
    std::hint::black_box(sealed.len());
    watch.elapsed_ns()
}
