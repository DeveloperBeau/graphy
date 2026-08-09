use std::time::Instant;

pub struct Stopwatch {
    started: Instant,
}

impl Stopwatch {
    pub fn start() -> Self {
        Stopwatch { started: Instant::now() }
    }

    pub fn elapsed_ns(&self) -> u128 {
        self.started.elapsed().as_nanos()
    }

}
