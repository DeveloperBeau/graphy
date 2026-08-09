#[derive(Clone)]
pub struct HistoryEntry {
    pub input: String,
    pub value: f64,
}

impl HistoryEntry {
    pub fn new(input: &str, value: f64) -> Self {
        HistoryEntry { input: input.trim().to_string(), value }
    }

    pub fn summary(&self) -> String {
        format!("{} = {}", self.input, self.value)
    }
}
