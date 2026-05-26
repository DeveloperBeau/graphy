// feature: struct, impl, impl-Trait-for-Type (implements edge),
//          import (single, braced, aliased, glob), cross-file call,
//          external call (to std::println - must not produce local edge).

use std::collections::HashMap;
use std::io::Result as IoResult;
use crate::helpers::format_name;
use crate::types::{Greet, State, UserId};
use crate::types::*;

pub struct Service {
    pub name: String,
    pub cache: HashMap<UserId, String>,
}

impl Service {
    pub fn new(name: &str) -> Self {
        Service { name: name.to_string(), cache: HashMap::new() }
    }

    pub fn run(&self) -> IoResult<()> {
        let greeting = format_name(&self.name);
        println!("{greeting}");
        let _state = State::Running;
        Ok(())
    }
}

impl Greet for Service {
    fn hi(&self) -> &'static str {
        "hello from service"
    }
}
