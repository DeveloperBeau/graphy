require_relative 'guard_positive'

def pow_square(x)
  value = guard_positive(x)
  value * value
end
