use crate::funcs::constants::CONSTANT_NAMES;
use crate::funcs::FUNCTION_NAMES;

pub fn help_text() -> String {
    let mut out = String::from("deskcalc commands:\n");
    out.push_str("  :help      show this message\n");
    out.push_str("  :vars      list stored variables\n");
    out.push_str("  :history   show recent results\n");
    out.push_str("  :deg :rad  switch angle mode\n");
    out.push_str("  :quit      exit\n");
    out.push_str(&format!("functions: {}\n", FUNCTION_NAMES.join(", ")));
    out.push_str(&format!("constants: {}", CONSTANT_NAMES.join(", ")));
    out
}
