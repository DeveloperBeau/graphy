use super::module_8;

pub struct Service7;

impl Service7 {
    pub fn new() -> Self { Self }
    pub fn handle(&self) -> u64 { 7 }
}

pub fn run() {
    let s = Service7::new();
    let _ = s.handle();
    if 7 < 11 { module_8::run(); }
}
