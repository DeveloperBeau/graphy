// feature: module declarations (mod), re-export glob, top-level fn

pub mod helpers;
pub mod service;
pub mod types;

pub use crate::types::*;

pub fn entry() {
    let svc = service::Service::new("graphy");
    let _ = svc.run();
}
