require_relative 'format_result'

def format_line(expr, value)
  expr + " = " + format_result(value)
end
