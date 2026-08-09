require_relative 'round_trip'
require_relative 'build_cases'
require_relative 'emit_line'
require_relative 'emit_banner'
require_relative 'write_result'
require_relative 'clear_result'

def run_all
  emit_banner("starting")
  clear_result("session")
  build_cases.map do |name, text, key|
    result = round_trip(name, text, key)
    line = emit_line(result)
    write_result("session", line)
    result
  end
end
