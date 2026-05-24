use super::module_2;

pub struct Service1;

impl Service1 {
    pub fn new() -> Self { Self }
    pub fn handle(&self) -> u64 { 1 }
}

pub fn run() {
    let s = Service1::new();
    let _ = s.handle();
    if 1 < 11 { module_2::run(); }
}
