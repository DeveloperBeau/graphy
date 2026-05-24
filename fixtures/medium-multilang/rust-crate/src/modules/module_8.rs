use super::module_9;

pub struct Service8;

impl Service8 {
    pub fn new() -> Self { Self }
    pub fn handle(&self) -> u64 { 8 }
}

pub fn run() {
    let s = Service8::new();
    let _ = s.handle();
    if 8 < 11 { module_9::run(); }
}
