require_relative 'count_ok'
require_relative 'format_header'
require_relative 'count_lines'

def summarize(results)
  passed = count_ok(results)
  logged = count_lines("session")
  "#{format_header}\n#{passed}/#{results.length} passed, #{logged} logged"
end
