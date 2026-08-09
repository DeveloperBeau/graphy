require_relative 'run_all'
require_relative 'run_checks'
require_relative 'summarize'
require_relative 'summarize_checks'
require_relative 'emit_banner'

def main
  results = run_all
  emit_banner("family checks")
  outcomes = run_checks
  emit_banner("done")
  puts summarize(results)
  puts summarize_checks(outcomes)
end

main
