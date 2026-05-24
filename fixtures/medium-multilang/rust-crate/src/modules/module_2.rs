use super::module_3;

pub struct Service2;

impl Service2 {
    pub fn new() -> Self { Self }
    pub fn handle(&self) -> u64 { 2 }
}

pub fn run() {
    let s = Service2::new();
    let _ = s.handle();
    if 2 < 11 { module_3::run(); }
}
