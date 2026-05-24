#!/usr/bin/env bash
# Run graphy on every fixture and emit a comparison report covering wall
# time, peak RSS, graph shape, and the relation histogram. Each fixture is
# benchmarked once per trial; the reported value is the best (min) wall
# time across $TRIALS runs and the worst (max) peak RSS.
#
# Usage: bench/compare.sh [fixtures-dir] [report-out] [trials]
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FIXTURES="${1:-$REPO_ROOT/fixtures}"
REPORT="${2:-$REPO_ROOT/bench/comparison.md}"
TRIALS="${3:-3}"

GRAPHY_BIN="$REPO_ROOT/target/release/graphy"

case "$(uname -s)" in
  Darwin) TIME_BIN="/usr/bin/time"; TIME_FLAG="-l" ;;
  Linux)  TIME_BIN="/usr/bin/time"; TIME_FLAG="-v" ;;
  *)      TIME_BIN=""; TIME_FLAG="" ;;
esac

echo "[compare] building graphy (release)..."
( cd "$REPO_ROOT" && cargo build --release --quiet )

ts="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

now_ns() { python3 -c 'import time; print(time.monotonic_ns())'; }

# Parse peak RSS in KB from /usr/bin/time output (portable across mac/linux).
peak_rss_kb() {
  local stderr_file="$1"
  python3 - "$stderr_file" <<'PY'
import re, sys
buf = open(sys.argv[1]).read()
m = re.search(r'(\d+)\s+maximum resident set size', buf)   # macOS, bytes
if m:
    print(int(m.group(1)) // 1024)
    sys.exit(0)
m = re.search(r'Maximum resident set size .*?:\s*(\d+)', buf)  # linux, KB
if m:
    print(int(m.group(1)))
    sys.exit(0)
print(0)
PY
}

run_once() {
  local fixture_dir="$1"; local out="$2"; local timefile="$3"
  rm -rf "$out"
  if [[ -n "$TIME_BIN" ]]; then
    "$TIME_BIN" $TIME_FLAG "$GRAPHY_BIN" "$fixture_dir" --out "$fixture_dir" \
      >/dev/null 2>"$timefile"
  else
    "$GRAPHY_BIN" "$fixture_dir" --out "$fixture_dir" >/dev/null
  fi
}

bench_one() {
  local fixture_dir="$1"; local out="$2"
  local best_ms="" best_rss=0
  local tmp_time
  tmp_time="$(mktemp)"
  for ((i=0; i<TRIALS; i++)); do
    local s e wall
    s=$(now_ns)
    run_once "$fixture_dir" "$out" "$tmp_time"
    e=$(now_ns)
    wall=$(( (e - s) / 1000000 ))
    if [[ -z "$best_ms" || "$wall" -lt "$best_ms" ]]; then best_ms="$wall"; fi
    if [[ -n "$TIME_BIN" && -s "$tmp_time" ]]; then
      local rss
      rss="$(peak_rss_kb "$tmp_time")"
      if (( rss > best_rss )); then best_rss="$rss"; fi
    fi
  done
  rm -f "$tmp_time"
  echo "${best_ms}|${best_rss}"
}

count_json() {
  local f="$1" expr="$2"
  if [[ -f "$f" ]]; then jq "$expr" "$f" 2>/dev/null || echo "-"
  else echo "-"; fi
}

# Histogram of relations as "rel1=count1,rel2=count2,...".
relations_csv() {
  local f="$1"
  if [[ -f "$f" ]]; then
    jq -r '[.edges[].relation] | group_by(.) | map({k:.[0], v:length}) | map("\(.k)=\(.v)") | join(",")' "$f" 2>/dev/null || echo ""
  else
    echo ""
  fi
}

format_kb() {
  python3 -c "import sys; n=int(sys.argv[1] or 0); print('—' if n==0 else f'{n/1024:.1f} MB')" "$1"
}

declare -a rows=()
declare -a rel_rows=()
for fx in "$FIXTURES"/*/; do
  [[ -d "$fx" ]] || continue
  label="$(basename "$fx")"
  echo "[compare] fixture: $label"
  out="$fx/graphy-out"

  res="$(bench_one "$fx" "$out")"
  IFS='|' read -r ms rss <<< "$res"
  nodes=$(count_json "$out/graph.json" '.nodes | length')
  edges=$(count_json "$out/graph.json" '.edges | length')
  rels="$(relations_csv "$out/graph.json")"

  rows+=("$label|$ms|$rss|$nodes|$edges")
  rel_rows+=("$label|$rels")
done

{
  echo "# graphy benchmark report"
  echo
  echo "_generated: ${ts}; trials per cell: ${TRIALS}_"
  echo
  echo "## Wall time (best of ${TRIALS})"
  echo
  echo "| fixture | wall (ms) |"
  echo "|---|---:|"
  for r in "${rows[@]}"; do
    IFS='|' read -r label ms _rss _n _e <<< "$r"
    echo "| $label | $ms |"
  done
  echo
  echo "## Peak RSS (worst of ${TRIALS})"
  echo
  echo "| fixture | RSS |"
  echo "|---|---:|"
  for r in "${rows[@]}"; do
    IFS='|' read -r label _ms rss _n _e <<< "$r"
    echo "| $label | $(format_kb "$rss") |"
  done
  echo
  echo "## Graph shape"
  echo
  echo "| fixture | nodes | edges |"
  echo "|---|---:|---:|"
  for r in "${rows[@]}"; do
    IFS='|' read -r label _ms _rss n e <<< "$r"
    echo "| $label | $n | $e |"
  done
  echo
  echo "## Relation distribution"
  echo
  for r in "${rel_rows[@]}"; do
    IFS='|' read -r label rels <<< "$r"
    echo "**$label**"
    echo
    echo "  - $rels"
    echo
  done
} > "$REPORT"

echo "[compare] wrote $REPORT"
