require_relative 'guard_positive'

def pow_cube(x)
  value = guard_positive(x)
  value * value * value
end
