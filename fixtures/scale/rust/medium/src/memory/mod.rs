pub mod ans;
pub mod store;

pub use ans::AnsRegister;
pub use store::VarStore;

/// Reserved names that `VarStore::set` refuses to shadow.
pub const RESERVED: &[&str] = &["ans", "pi", "e", "tau", "phi"];

pub fn is_reserved(name: &str) -> bool {
    RESERVED.contains(&name)
}
