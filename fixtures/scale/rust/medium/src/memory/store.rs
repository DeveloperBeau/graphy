use crate::funcs::constants::lookup_constant;
use crate::memory::is_reserved;
use std::collections::HashMap;

pub struct VarStore {
    values: HashMap<String, f64>,
}

impl VarStore {
    pub fn with_defaults() -> Self {
        VarStore { values: HashMap::new() }
    }

    pub fn get(&self, name: &str) -> Option<f64> {
        if let Some(constant) = lookup_constant(name) {
            return Some(constant);
        }
        self.values.get(name).copied()
    }

    pub fn set(&mut self, name: &str, value: f64) {
        if is_reserved(name) {
            return;
        }
        self.values.insert(name.to_string(), value);
    }

    pub fn snapshot(&self) -> Vec<(String, f64)> {
        let mut pairs: Vec<(String, f64)> =
            self.values.iter().map(|(k, v)| (k.clone(), *v)).collect();
        pairs.sort_by(|a, b| a.0.cmp(&b.0));
        pairs
    }
}
