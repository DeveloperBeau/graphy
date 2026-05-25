#!/usr/bin/env bash
# Synthesize ~5000 Rust files in a deterministic shape for bench/test.
set -euo pipefail
OUT="${1:-$(cd "$(dirname "$0")" && pwd)/large-synthetic}"
rm -rf "$OUT" && mkdir -p "$OUT/src/modules"
echo 'fn main() {}' > "$OUT/src/main.rs"
mod_list=""
for i in $(seq 0 49); do
  for j in $(seq 0 99); do
    name="m_${i}_${j}"
    next=$(( (j + 1) % 100 ))
    cat > "$OUT/src/modules/${name}.rs" <<EOF
pub struct S$j;
impl S$j { pub fn hit() {} pub fn other() {} }
pub fn fan() { S$j::hit(); }
pub fn next_call() { m_${i}_${next}::fan(); }
EOF
    mod_list+="pub mod ${name};\n"
  done
done
printf "$mod_list" > "$OUT/src/modules/mod.rs"
find "$OUT" -type f | wc -l
