require_relative 'guard_positive'

def pow_sqrt(x)
  value = guard_positive(x)
  Math.sqrt(value)
end
