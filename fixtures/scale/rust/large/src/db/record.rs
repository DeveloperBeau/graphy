#[derive(Debug, Clone)]
pub struct RunRecord {
    pub family: String,
    pub op: String,
    pub input_len: usize,
    pub elapsed_ns: u128,
    pub ok: bool,
}

impl RunRecord {
    pub fn new(family: &str, op: &str, input_len: usize, elapsed_ns: u128, ok: bool) -> Self {
        RunRecord {
            family: family.to_string(),
            op: op.to_string(),
            input_len,
            elapsed_ns,
            ok,
        }
    }

    pub fn csv_line(&self) -> String {
        format!(
            "{},{},{},{},{}",
            self.family, self.op, self.input_len, self.elapsed_ns, self.ok
        )
    }
}
