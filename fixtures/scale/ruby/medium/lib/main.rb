require_relative 'run_batch'
require_relative 'funcs'

def main
  exprs = ["1 + 2 * 3", "(4 + 5) / 3", "2 ^ 8", "10 - 4 - 3"]
  log = run_batch(exprs)
  puts "---"
  puts log.dump
  puts apply_named("trig_sine", [0.5])
  puts apply_named("bi_hypotenuse", [3, 4])
end

main
