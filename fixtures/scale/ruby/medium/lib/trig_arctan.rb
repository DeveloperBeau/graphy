require_relative 'guard_number'

def trig_arctan(x)
  value = guard_number(x)
  Math.atan(value)
end
