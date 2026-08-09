use crate::config::Settings;
use crate::memory::{AnsRegister, VarStore};

pub struct Env {
    pub vars: VarStore,
    pub ans: AnsRegister,
    pub settings: Settings,
}

impl Env {
    pub fn new(settings: Settings) -> Self {
        Env {
            vars: VarStore::with_defaults(),
            ans: AnsRegister::empty(),
            settings,
        }
    }
}
