use crate::live::BAR_WIDTH;

pub struct ProgressBar {
    total: usize,
    done: usize,
}

impl ProgressBar {
    pub fn new(total: usize) -> Self {
        ProgressBar { total: total.max(1), done: 0 }
    }

    pub fn tick(&mut self) {
        self.done = (self.done + 1).min(self.total);
    }

    pub fn render(&self) -> String {
        let filled = self.done * BAR_WIDTH / self.total;
        format!(
            "[{}{}] {}/{}",
            "=".repeat(filled),
            " ".repeat(BAR_WIDTH - filled),
            self.done,
            self.total
        )
    }
}
