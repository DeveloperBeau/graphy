require_relative 'evaluate'
require_relative 'history'
require_relative 'format_line'

def run_batch(expressions)
  log = History.new
  expressions.each do |expr|
    value = evaluate(expr)
    log.record(expr, value)
    puts format_line(expr, value)
  end
  log
end
