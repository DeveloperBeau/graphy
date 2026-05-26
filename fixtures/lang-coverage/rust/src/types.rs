// feature: enum, trait, type-alias, const, static, macro_rules

pub const MAX_RETRIES: u32 = 3;
pub static SERVICE_NAME: &str = "graphy-rust-fixture";

macro_rules! make_greeting {
    ($name:expr) => {
        format!("hi, {}", $name)
    };
}

pub type UserId = u64;

pub enum State {
    Idle,
    Running,
    Done,
}

pub trait Greet {
    fn hi(&self) -> &'static str;
}
