require_relative 'format_row'

def emit_line(result)
  line = format_row(result)
  puts line
  line
end
