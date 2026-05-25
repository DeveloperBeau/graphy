#!/usr/bin/env bash
# Synthesize a medium-sized mixed-language project under fixtures/medium-multilang/.
# Output is deterministic so successive bench runs compare against a stable corpus
# without random drift between runs.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)/medium-multilang"
rm -rf "$ROOT"
mkdir -p "$ROOT"/{rust-crate/src/modules,py-pkg/pkg/handlers,py-pkg/pkg/util,ts-app/src/{controllers,services,models},go-pkg/{server,handlers,store}}

# ---- rust-crate (15 files) -----------------------------------------------
cat > "$ROOT/rust-crate/Cargo.toml" <<EOF
[package]
name = "rust-crate"
version = "0.0.0"
edition = "2024"
publish = false
[[bin]]
name = "rust-crate"
path = "src/main.rs"
EOF

cat > "$ROOT/rust-crate/src/main.rs" <<EOF
mod modules;
fn main() { modules::module_0::run(); modules::module_7::run(); }
EOF

mod_list=""
for i in $(seq 0 11); do
  mod_list+="pub mod module_${i};\n"
done
printf "$mod_list" > "$ROOT/rust-crate/src/modules/mod.rs"

for i in $(seq 0 11); do
  next=$(( (i + 1) % 12 ))
  cat > "$ROOT/rust-crate/src/modules/module_${i}.rs" <<EOF
use super::module_${next};

pub struct Service${i};

impl Service${i} {
    pub fn new() -> Self { Self }
    pub fn handle(&self) -> u64 { ${i} }
}

pub fn run() {
    let s = Service${i}::new();
    let _ = s.handle();
    if ${i} < 11 { module_${next}::run(); }
}
EOF
done

# ---- py-pkg (15 files) ---------------------------------------------------
touch "$ROOT/py-pkg/pkg/__init__.py"
touch "$ROOT/py-pkg/pkg/handlers/__init__.py"
touch "$ROOT/py-pkg/pkg/util/__init__.py"

cat > "$ROOT/py-pkg/pkg/util/log.py" <<'EOF'
def info(msg: str) -> None:
    print(f"[i] {msg}")

def warn(msg: str) -> None:
    print(f"[w] {msg}")
EOF

cat > "$ROOT/py-pkg/pkg/util/fmt.py" <<'EOF'
from pkg.util.log import info

def banner(title: str) -> None:
    info("=" * len(title))
    info(title)
    info("=" * len(title))
EOF

for i in $(seq 0 9); do
  cat > "$ROOT/py-pkg/pkg/handlers/handler_${i}.py" <<EOF
from pkg.util.log import info, warn
from pkg.util.fmt import banner


class Handler${i}:
    def __init__(self) -> None:
        self.kind = "handler_${i}"

    def handle(self) -> int:
        banner(self.kind)
        info("ready")
        if ${i} % 3 == 0:
            warn("noisy")
        return ${i}


def run() -> int:
    h = Handler${i}()
    return h.handle()
EOF
done

cat > "$ROOT/py-pkg/pkg/__main__.py" <<'EOF'
from pkg.handlers import handler_0, handler_3, handler_7

def main() -> int:
    handler_0.run()
    handler_3.run()
    handler_7.run()
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
EOF

# ---- ts-app (15 files) ---------------------------------------------------
cat > "$ROOT/ts-app/src/index.ts" <<'EOF'
import { App } from "./app";
new App().start();
EOF

cat > "$ROOT/ts-app/src/app.ts" <<'EOF'
import { Controller0 } from "./controllers/c0";
import { Controller3 } from "./controllers/c3";
import { Controller7 } from "./controllers/c7";

export class App {
  start(): void {
    new Controller0().handle();
    new Controller3().handle();
    new Controller7().handle();
  }
}
EOF

cat > "$ROOT/ts-app/src/models/entity.ts" <<'EOF'
export interface Entity {
  id: number;
  kind: string;
}
EOF

cat > "$ROOT/ts-app/src/services/store.ts" <<'EOF'
import type { Entity } from "../models/entity";

export class Store {
  private items: Entity[] = [];
  put(e: Entity): void { this.items.push(e); }
  all(): Entity[] { return this.items; }
}
EOF

for i in $(seq 0 9); do
  cat > "$ROOT/ts-app/src/controllers/c${i}.ts" <<EOF
import { Store } from "../services/store";
import type { Entity } from "../models/entity";

export class Controller${i} {
  private store = new Store();

  handle(): void {
    const e: Entity = { id: ${i}, kind: "c${i}" };
    this.store.put(e);
    const n = this.store.all().length;
    console.log("c${i}:", n);
  }
}
EOF
done

# ---- go-pkg (10 files) ---------------------------------------------------
cat > "$ROOT/go-pkg/go.mod" <<'EOF'
module example.com/medium

go 1.22
EOF

cat > "$ROOT/go-pkg/main.go" <<'EOF'
package main

import (
	"example.com/medium/server"
)

func main() {
	server.Run()
}
EOF

cat > "$ROOT/go-pkg/server/server.go" <<'EOF'
package server

import (
	"example.com/medium/handlers"
	"example.com/medium/store"
)

func Run() {
	s := store.New()
	handlers.Health(s)
	handlers.UserList(s)
	handlers.UserCreate(s, "ada")
}
EOF

cat > "$ROOT/go-pkg/store/store.go" <<'EOF'
package store

type Store struct{ items []string }

func New() *Store { return &Store{} }

func (s *Store) Add(name string) { s.items = append(s.items, name) }

func (s *Store) All() []string { return s.items }
EOF

for name in health userList userCreate orderList orderCreate inventory metrics; do
  cat > "$ROOT/go-pkg/handlers/${name}.go" <<EOF
package handlers

import (
	"fmt"

	"example.com/medium/store"
)

func $(echo "$name" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')(args ...any) {
	s, _ := args[0].(*store.Store)
	if s == nil {
		s = store.New()
	}
	for _, a := range args[1:] {
		if v, ok := a.(string); ok {
			s.Add(v)
		}
	}
	fmt.Println("${name}:", len(s.All()))
}
EOF
done

# Total file count
find "$ROOT" -type f | wc -l | xargs printf "[gen-medium] wrote %s files under %s\n" '{}' "$ROOT" 2>/dev/null || true
echo "[gen-medium] root: $ROOT"
find "$ROOT" -type f | wc -l
