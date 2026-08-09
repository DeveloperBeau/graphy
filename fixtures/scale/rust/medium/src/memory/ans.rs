pub struct AnsRegister {
    last: f64,
    set_count: usize,
}

impl AnsRegister {
    pub fn empty() -> Self {
        AnsRegister { last: 0.0, set_count: 0 }
    }

    pub fn record(&mut self, value: f64) {
        self.last = value;
        self.set_count += 1;
    }

    pub fn value(&self) -> f64 {
        self.last
    }

    pub fn has_value(&self) -> bool {
        self.set_count > 0
    }
}
