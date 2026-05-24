use super::module_1;

pub struct Service0;

impl Service0 {
    pub fn new() -> Self { Self }
    pub fn handle(&self) -> u64 { 0 }
}

pub fn run() {
    let s = Service0::new();
    let _ = s.handle();
    if 0 < 11 { module_1::run(); }
}
