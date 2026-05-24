use crate::handlers;
use crate::middleware::log_request;

pub struct Router;

impl Router {
    pub fn new() -> Self { Self }

    pub fn serve(&self) {
        log_request("GET /healthz");
        handlers::healthz();
        log_request("GET /users/1");
        handlers::get_user(1);
    }
}
