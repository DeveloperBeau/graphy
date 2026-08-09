require_relative 'guard_positive'

def pow_cbrt(x)
  value = guard_positive(x)
  Math.cbrt(value)
end
