require_relative 'guard_number'

def conv_fahrenheit(x)
  value = guard_number(x)
  value * 9.0 / 5.0 + 32.0
end
