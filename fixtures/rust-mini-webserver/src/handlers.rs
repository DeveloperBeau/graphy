use crate::middleware::audit;

pub fn healthz() {
    audit("healthz");
    println!("ok");
}

pub fn get_user(id: u64) {
    audit("get_user");
    println!("user {id}");
}
