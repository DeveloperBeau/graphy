require_relative 'guard_number'

def trig_sine(x)
  value = guard_number(x)
  Math.sin(value)
end
