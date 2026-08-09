require_relative 'guard_number'

def conv_degrees(x)
  value = guard_number(x)
  value * 180.0 / Math::PI
end
