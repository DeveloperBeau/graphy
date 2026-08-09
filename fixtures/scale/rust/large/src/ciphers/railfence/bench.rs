use crate::ciphers::railfence::cipher::railfence_encrypt;
use crate::ciphers::railfence::keys::railfence_default_key;
use crate::core::sample::sample_ascii;
use crate::core::timer::Stopwatch;

/// Time one encryption pass over `input_len` generated letters.
pub fn railfence_measure(input_len: usize) -> u128 {
    let data = sample_ascii(input_len);
    let key = railfence_default_key();
    let watch = Stopwatch::start();
    let sealed = railfence_encrypt(&data, key);
    std::hint::black_box(sealed.len());
    watch.elapsed_ns()
}
