use crate::ciphers::substitution::cipher::substitution_encrypt;
use crate::ciphers::substitution::keys::substitution_default_key;
use crate::core::sample::sample_ascii;
use crate::core::timer::Stopwatch;

/// Time one encryption pass over `input_len` generated letters.
pub fn substitution_measure(input_len: usize) -> u128 {
    let data = sample_ascii(input_len);
    let key = substitution_default_key();
    let watch = Stopwatch::start();
    let sealed = substitution_encrypt(&data, key);
    std::hint::black_box(sealed.len());
    watch.elapsed_ns()
}
