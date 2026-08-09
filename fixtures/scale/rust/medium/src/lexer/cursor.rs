pub struct Cursor {
    chars: Vec<char>,
    pos: usize,
}

impl Cursor {
    pub fn new(input: &str) -> Self {
        Cursor { chars: input.chars().collect(), pos: 0 }
    }

    pub fn peek(&self) -> Option<char> {
        self.chars.get(self.pos).copied()
    }

    pub fn bump(&mut self) -> Option<char> {
        let ch = self.peek();
        if ch.is_some() {
            self.pos += 1;
        }
        ch
    }

    pub fn eat_while(&mut self, pred: impl Fn(char) -> bool) -> String {
        let mut out = String::new();
        while let Some(ch) = self.peek() {
            if !pred(ch) {
                break;
            }
            out.push(ch);
            self.pos += 1;
        }
        out
    }
}
