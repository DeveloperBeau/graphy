require_relative 'guard_number'

def conv_celsius(x)
  value = guard_number(x)
  (value - 32.0) * 5.0 / 9.0
end
