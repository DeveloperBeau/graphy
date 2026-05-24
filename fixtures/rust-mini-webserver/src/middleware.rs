pub fn log_request(line: &str) {
    println!("[req] {line}");
}

pub fn audit(event: &str) {
    println!("[audit] {event}");
}
