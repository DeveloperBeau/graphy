/// Small deterministic generator so runs are reproducible without
/// pulling in an external crate.
pub struct XorShift32 {
    state: u32,
}

impl XorShift32 {
    pub fn new(seed: u32) -> Self {
        XorShift32 { state: seed.max(1) }
    }

    pub fn next_u32(&mut self) -> u32 {
        let mut x = self.state;
        x ^= x << 13;
        x ^= x >> 17;
        x ^= x << 5;
        self.state = x;
        x
    }

    pub fn fill(&mut self, len: usize) -> Vec<u8> {
        (0..len).map(|_| (self.next_u32() >> 16) as u8).collect()
    }
}
