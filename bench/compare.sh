#!/usr/bin/env bash
# Run graphy on every fixture and emit a comparison report covering wall
# time, peak RSS, graph shape, the relation histogram, and the post-dedup
# cache efficiency (cold vs warm imports_resolved).
#
# Usage: bench/compare.sh [fixtures-dir] [report-out] [trials]
#
# Environment:
#   BENCH_ASSERT=1       Fail with exit code 1 if any fixture's warm
#                        dedup_imports_resolved exceeds 20% of its cold count
#                        (and cold count > 0).
#   BENCH_ASSERT_SCC=1   Fail with exit code 1 if any fixture's SCC-on warm
#                        wall time is more than 1.10x the SCC-off warm wall
#                        time. Manual / opt-in (timing-sensitive on busy
#                        machines).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FIXTURES="${1:-$REPO_ROOT/fixtures}"
REPORT="${2:-$REPO_ROOT/bench/comparison.md}"
TRIALS="${3:-3}"
BENCH_ASSERT="${BENCH_ASSERT:-0}"
BENCH_ASSERT_SCC="${BENCH_ASSERT_SCC:-0}"

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

# Read dedup_imports_resolved from graphy-out/stats.json.
read_imports_resolved() {
  local stats_file="$1"
  if [[ -f "$stats_file" ]]; then
    python3 - "$stats_file" <<'PY'
import json, sys
try:
    with open(sys.argv[1]) as f:
        d = json.load(f)
    print(int(d.get("dedup_imports_resolved", 0)))
except Exception:
    print(0)
PY
  else
    echo 0
  fi
}

run_once() {
  local fixture_dir="$1"; local out="$2"; local timefile="$3"
  rm -rf "$out"
  if [[ -n "$TIME_BIN" ]]; then
    "$TIME_BIN" $TIME_FLAG "$GRAPHY_BIN" "$fixture_dir" --out "$fixture_dir" \
      >/dev/null 2>"$timefile"
  else
    "$GRAPHY_BIN" "$fixture_dir" --out "$fixture_dir" >/dev/null 2>/dev/null
  fi
}

# Run graphy a second time WITHOUT clearing the output (warm/incremental run).
run_warm() {
  local fixture_dir="$1"; local timefile="$2"
  if [[ -n "$TIME_BIN" ]]; then
    "$TIME_BIN" $TIME_FLAG "$GRAPHY_BIN" "$fixture_dir" --out "$fixture_dir" \
      >/dev/null 2>"$timefile"
  else
    "$GRAPHY_BIN" "$fixture_dir" --out "$fixture_dir" >/dev/null 2>/dev/null
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

# Measure dedup cache efficiency: cold run then warm run on the same fixture.
# Outputs "cold_imports|warm_imports".
bench_dedup_cache() {
  local fixture_dir="$1"; local out="$2"
  local stats_file="$out/stats.json"
  local tmp_time
  tmp_time="$(mktemp)"

  # Cold run: blow away prior output to force a full build + dedup.
  rm -rf "$out"
  run_once "$fixture_dir" "$out" "$tmp_time"
  local cold_imports
  cold_imports="$(read_imports_resolved "$stats_file")"

  # Warm run: re-run without clearing output so incremental path is taken.
  run_warm "$fixture_dir" "$tmp_time"
  local warm_imports
  warm_imports="$(read_imports_resolved "$stats_file")"

  rm -f "$tmp_time"
  echo "${cold_imports}|${warm_imports}"
}

# Measure SCC widening overhead on the warm path: warm run with vs without
# --no-scc-expansion. Outputs "wall_on_ms|wall_off_ms".
bench_scc_overhead() {
  local fixture_dir="$1"; local out="$2"
  local tmp_time
  tmp_time="$(mktemp)"

  # Warm both passes (cache must exist already, from bench_dedup_cache).
  local s e on_ms off_ms

  s=$(now_ns)
  "$GRAPHY_BIN" "$fixture_dir" --out "$fixture_dir" >/dev/null 2>/dev/null
  e=$(now_ns)
  on_ms=$(( (e - s) / 1000000 ))

  s=$(now_ns)
  "$GRAPHY_BIN" "$fixture_dir" --out "$fixture_dir" --no-scc-expansion >/dev/null 2>/dev/null
  e=$(now_ns)
  off_ms=$(( (e - s) / 1000000 ))

  rm -f "$tmp_time"
  echo "${on_ms}|${off_ms}"
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
declare -a dedup_rows=()
declare -a scc_rows=()
assert_failures=()

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

  # Measure dedup cache hit rate (cold vs warm imports_resolved).
  dedup_res="$(bench_dedup_cache "$fx" "$out")"
  IFS='|' read -r cold_imports warm_imports <<< "$dedup_res"

  # Compute reduction % (skip if cold == 0 to avoid div-by-zero).
  if (( cold_imports > 0 )); then
    reduction_pct=$(python3 -c "print(f'{(1 - $warm_imports / $cold_imports) * 100:.1f}')")
    # BENCH_ASSERT: warm must be <= 20% of cold (80% reduction).
    if [[ "$BENCH_ASSERT" == "1" ]]; then
      passes=$(python3 -c "print('yes' if $warm_imports <= 0.20 * $cold_imports else 'no')")
      if [[ "$passes" == "no" ]]; then
        assert_failures+=("$label: cold=$cold_imports warm=$warm_imports reduction=${reduction_pct}% (need >=80%)")
      fi
    fi
  else
    reduction_pct="n/a"
  fi

  # Measure SCC widening overhead (warm path: scc-on vs scc-off).
  scc_res="$(bench_scc_overhead "$fx" "$out")"
  IFS='|' read -r scc_on_ms scc_off_ms <<< "$scc_res"

  # Compute ratio (scc_on / scc_off) as a percentage; skip if scc_off is 0.
  if (( scc_off_ms > 0 )); then
    scc_ratio_pct=$(python3 -c "print(f'{($scc_on_ms / $scc_off_ms) * 100:.1f}')")
    if [[ "$BENCH_ASSERT_SCC" == "1" ]]; then
      passes=$(python3 -c "print('yes' if $scc_on_ms <= 1.10 * $scc_off_ms else 'no')")
      if [[ "$passes" == "no" ]]; then
        assert_failures+=("$label: scc_on=${scc_on_ms}ms scc_off=${scc_off_ms}ms ratio=${scc_ratio_pct}% (need <=110%)")
      fi
    fi
  else
    scc_ratio_pct="n/a"
  fi

  rows+=("$label|$ms|$rss|$nodes|$edges")
  rel_rows+=("$label|$rels")
  dedup_rows+=("$label|$cold_imports|$warm_imports|$reduction_pct")
  scc_rows+=("$label|$scc_on_ms|$scc_off_ms|$scc_ratio_pct")
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
  echo "## Post-dedup cache efficiency"
  echo
  echo "Measures \`dedup_imports_resolved\` on a cold run (full build) versus a"
  echo "warm run (incremental, all files cached). A healthy warm run should"
  echo "resolve ≥80% fewer imports than cold because dedup maps are pre-applied."
  echo
  echo "| fixture | cold imports | warm imports | reduction |"
  echo "|---|---:|---:|---:|"
  for r in "${dedup_rows[@]}"; do
    IFS='|' read -r label cold warm reduction <<< "$r"
    echo "| $label | $cold | $warm | ${reduction}% |"
  done
  echo ""
  echo "## SCC widening overhead (warm path)"
  echo ""
  echo "| Fixture | SCC on (ms) | SCC off (ms) | on/off |"
  echo "| --- | ---: | ---: | ---: |"
  for row in "${scc_rows[@]}"; do
    IFS='|' read -r label son soff ratio <<< "$row"
    echo "| $label | $son | $soff | ${ratio}% |"
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

# Report assertion results.
if [[ "$BENCH_ASSERT" == "1" ]]; then
  if [[ ${#assert_failures[@]} -gt 0 ]]; then
    echo "[compare] BENCH_ASSERT failures:"
    for f in "${assert_failures[@]}"; do
      echo "  FAIL: $f"
    done
    exit 1
  else
    echo "[compare] BENCH_ASSERT: all fixtures pass the >=80% dedup-cache reduction threshold"
  fi
fi
