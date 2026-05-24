use super::module_10;

pub struct Service9;

impl Service9 {
    pub fn new() -> Self { Self }
    pub fn handle(&self) -> u64 { 9 }
}

pub fn run() {
    let s = Service9::new();
    let _ = s.handle();
    if 9 < 11 { module_10::run(); }
}
