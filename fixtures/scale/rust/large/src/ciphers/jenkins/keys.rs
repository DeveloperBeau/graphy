/// Key material for the jenkins family (digest seed).
pub const JENKINS_KEY_KIND: &str = "digest seed";

pub fn jenkins_default_key() -> u64 {
    0
}

/// One-line key description for the report footer.
pub fn jenkins_key_label() -> String {
    format!("jenkins <{}>", JENKINS_KEY_KIND)
}
