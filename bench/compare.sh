#!/usr/bin/env bash
# Run graphy + graphy against every fixture; emit a comparison report.
#
# Usage: bench/compare.sh [fixtures-dir] [report-out] [trials]
#
# For each fixture we run each engine $TRIALS times. We report:
#   - wall time   (min across trials)
#   - peak RSS    (max across trials, from /usr/bin/time)
#   - graph shape (nodes + edges from last run)
#   - relation histogram diff (graphy vs graphy)
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FIXTURES="${1:-$REPO_ROOT/fixtures}"
REPORT="${2:-$REPO_ROOT/bench/comparison.md}"
TRIALS="${3:-3}"

GRAPHY_BIN="$REPO_ROOT/target/release/graphy"
HAVE_LEGACY=0
command -v graphy >/dev/null 2>&1 && HAVE_LEGACY=1

case "$(uname -s)" in
  Darwin) TIME_BIN="/usr/bin/time"; TIME_FLAG="-l" ;;
  Linux)  TIME_BIN="/usr/bin/time"; TIME_FLAG="-v" ;;
  *)      TIME_BIN=""; TIME_FLAG="" ;;
esac

echo "[compare] building graphy (release)..."
( cd "$REPO_ROOT" && cargo build --release --quiet )

ts="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

now_ns() { python3 -c 'import time; print(time.monotonic_ns())'; }

# Capture peak RSS in KB from `/usr/bin/time` output, portable across mac/linux.
peak_rss_kb() {
  local stderr_file="$1"
  python3 - "$stderr_file" <<'PY'
import re, sys
buf = open(sys.argv[1]).read()
# macOS:   "       1421312  maximum resident set size"
m = re.search(r'(\d+)\s+maximum resident set size', buf)
if m:
    # macOS reports bytes; convert to KB.
    print(int(m.group(1)) // 1024)
    sys.exit(0)
# Linux:   "Maximum resident set size (kbytes): 12345"
m = re.search(r'Maximum resident set size .*?:\s*(\d+)', buf)
if m:
    print(int(m.group(1)))
    sys.exit(0)
print(0)
PY
}

run_engine() {
  local engine="$1"; local fixture_dir="$2"; local out="$3"; local timefile="$4"
  rm -rf "$out"
  case "$engine" in
    graphy)
      if [[ -n "$TIME_BIN" ]]; then
        "$TIME_BIN" $TIME_FLAG "$GRAPHY_BIN" "$fixture_dir" --out "$fixture_dir" \
          >/dev/null 2>"$timefile"
      else
        "$GRAPHY_BIN" "$fixture_dir" --out "$fixture_dir" >/dev/null
      fi
      ;;
    graphy)
      mkdir -p "$out"
      echo '{"nodes":[],"edges":[]}' > "$out/graph.json"
      if [[ -n "$TIME_BIN" ]]; then
        ( cd "$fixture_dir" && \
          "$TIME_BIN" $TIME_FLAG graphy . >/dev/null 2>"$timefile" || true )
      else
        ( cd "$fixture_dir" && graphy . >/dev/null 2>&1 || true )
      fi
      ;;
  esac
}

bench_engine() {
  local engine="$1"; local fixture_dir="$2"; local out="$3"
  local best_ms="" best_rss=0
  local tmp_time
  tmp_time="$(mktemp)"
  for ((i=0; i<TRIALS; i++)); do
    local s e wall
    s=$(now_ns)
    run_engine "$engine" "$fixture_dir" "$out" "$tmp_time"
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

# Histogram of relations as "rel1=count1,rel2=count2,..."
relations_csv() {
  local f="$1"
  if [[ -f "$f" ]]; then
    jq -r '[.edges[].relation] | group_by(.) | map({k:.[0], v:length}) | map("\(.k)=\(.v)") | join(",")' "$f" 2>/dev/null || echo ""
  else
    echo ""
  fi
}

declare -a rows=()
declare -a rel_rows=()
for fx in "$FIXTURES"/*/; do
  [[ -d "$fx" ]] || continue
  label="$(basename "$fx")"
  echo "[compare] fixture: $label"
  out="$fx/graphy-out"

  graphy_res="$(bench_engine graphy "$fx" "$out")"
  IFS='|' read -r graphy_ms graphy_rss <<< "$graphy_res"
  g_nodes=$(count_json "$out/graph.json" '.nodes | length')
  g_edges=$(count_json "$out/graph.json" '.edges | length')
  g_rels="$(relations_csv "$out/graph.json")"

  if [[ "$HAVE_LEGACY" -eq 1 ]]; then
    graphy_res="$(bench_engine graphy "$fx" "$out")"
    IFS='|' read -r graphy_ms graphy_rss <<< "$graphy_res"
    f_nodes=$(count_json "$out/graph.json" '.nodes | length')
    f_edges=$(count_json "$out/graph.json" '.edges | length')
    f_rels="$(relations_csv "$out/graph.json")"
    if [[ "$graphy_ms" -gt 0 ]]; then
      speedup=$(python3 -c "print(f'{$graphy_ms/$graphy_ms:.1f}×')")
    else
      speedup="-"
    fi
  else
    graphy_ms="-"; graphy_rss=0; f_nodes="-"; f_edges="-"; speedup="-"; f_rels=""
  fi
  rows+=("$label|$graphy_ms|$graphy_ms|$speedup|$graphy_rss|$graphy_rss|$g_nodes|$g_edges|$f_nodes|$f_edges")
  rel_rows+=("$label||graphy: $g_rels||graphy: $f_rels")
done

format_kb() {
  python3 -c "import sys; n=int(sys.argv[1] or 0); print('—' if n==0 else f'{n/1024:.1f} MB')" "$1"
}

{
  echo "# graphy vs graphy — comparison report"
  echo
  echo "_generated: ${ts}; trials per cell: ${TRIALS}_"
  echo
  echo "## Wall time (best of ${TRIALS})"
  echo
  echo "| fixture | graphy (ms) | graphy (ms) | speedup |"
  echo "|---|---:|---:|---:|"
  for r in "${rows[@]}"; do
    IFS='|' read -r label g_ms f_ms sp _g_rss _f_rss _gn _ge _fn _fe <<< "$r"
    echo "| $label | $g_ms | $f_ms | $sp |"
  done
  echo
  echo "## Peak RSS (worst of ${TRIALS})"
  echo
  echo "| fixture | graphy | graphy |"
  echo "|---|---:|---:|"
  for r in "${rows[@]}"; do
    IFS='|' read -r label _g_ms _f_ms _sp g_rss f_rss _gn _ge _fn _fe <<< "$r"
    echo "| $label | $(format_kb "$g_rss") | $(format_kb "$f_rss") |"
  done
  echo
  echo "## Graph shape"
  echo
  echo "| fixture | graphy nodes | graphy nodes | graphy edges | graphy edges |"
  echo "|---|---:|---:|---:|---:|"
  for r in "${rows[@]}"; do
    IFS='|' read -r label _g_ms _f_ms _sp _g_rss _f_rss gn ge fn fe <<< "$r"
    echo "| $label | $gn | $fn | $ge | $fe |"
  done
  echo
  echo "## Relation distribution"
  echo
  for r in "${rel_rows[@]}"; do
    IFS='|' read -r label _ g _ f <<< "$r"
    echo "**$label**"
    echo
    echo "  - $g"
    echo "  - $f"
    echo
  done
  if [[ "$HAVE_LEGACY" -eq 1 ]]; then
    echo "> _Note:_ \`graphy\` is the no-LLM extract+graph path. In v8"
    echo "> it re-extracts nodes but does not always emit edges on the first"
    echo "> call (the edge / call-graph pass runs in a separate stage)."
  else
    echo "> _Note_: \`graphy\` was not on PATH, so only graphy numbers are present."
    echo "> Install with \`uv tool install graphy\` then rerun."
  fi
} > "$REPORT"

echo "[compare] wrote $REPORT"
