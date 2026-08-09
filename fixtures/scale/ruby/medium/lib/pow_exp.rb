require_relative 'guard_positive'

def pow_exp(x)
  value = guard_positive(x)
  Math.exp(value)
end
