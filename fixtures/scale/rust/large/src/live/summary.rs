use crate::core::stats::{format_ns, mean_ns};
use crate::core::version_line;
use crate::live::separator;

pub struct Summary {
    passed: usize,
    failed: usize,
    samples: Vec<u128>,
    slowest_ns: u128,
    slowest_family: String,
}

impl Summary {
    pub fn new() -> Self {
        Summary { passed: 0, failed: 0, samples: Vec::new(), slowest_ns: 0, slowest_family: String::new() }
    }

    pub fn add_verify(&mut self, _family: &str, ok: bool) {
        if ok {
            self.passed += 1;
        } else {
            self.failed += 1;
        }
    }

    pub fn add_measure(&mut self, family: &str, elapsed_ns: u128) {
        self.samples.push(elapsed_ns);
        if elapsed_ns > self.slowest_ns {
            self.slowest_ns = elapsed_ns;
            self.slowest_family = family.to_string();
        }
    }

    pub fn print_final(&self) {
        println!("{}", separator());
        println!("{}: {} passed, {} failed", version_line(), self.passed, self.failed);
        println!("mean: {}", format_ns(mean_ns(&self.samples) as u128));
        println!("slowest: {} at {}", self.slowest_family, format_ns(self.slowest_ns));
    }
}
