mod handlers;
mod middleware;
mod router;

fn main() {
    let r = router::Router::new();
    r.serve();
}
