require_relative 'add'
require_relative 'subtract'
require_relative 'multiply'
require_relative 'divide'
require_relative 'power'

def apply_op(op, a, b)
  case op
  when "+" then add(a, b)
  when "-" then subtract(a, b)
  when "*" then multiply(a, b)
  when "/" then divide(a, b)
  when "^" then power(a, b)
  end
end
