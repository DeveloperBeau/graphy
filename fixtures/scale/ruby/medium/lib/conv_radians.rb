require_relative 'guard_number'

def conv_radians(x)
  value = guard_number(x)
  value * Math::PI / 180.0
end
