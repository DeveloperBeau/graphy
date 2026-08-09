require_relative 'guard_number'

def trig_tangent(x)
  value = guard_number(x)
  Math.tan(value)
end
