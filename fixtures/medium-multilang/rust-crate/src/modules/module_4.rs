use super::module_5;

pub struct Service4;

impl Service4 {
    pub fn new() -> Self { Self }
    pub fn handle(&self) -> u64 { 4 }
}

pub fn run() {
    let s = Service4::new();
    let _ = s.handle();
    if 4 < 11 { module_5::run(); }
}
