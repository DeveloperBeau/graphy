use unicode_width::UnicodeWidthStr;

pub fn display_width(text: &str) -> usize {
    UnicodeWidthStr::width(text)
}

pub fn pad(count: usize) -> String {
    " ".repeat(count)
}

pub fn truncate_to(text: &str, width: usize) -> String {
    let mut out = String::new();
    for ch in text.chars() {
        if display_width(&out) + 1 > width {
            break;
        }
        out.push(ch);
    }
    out
}
