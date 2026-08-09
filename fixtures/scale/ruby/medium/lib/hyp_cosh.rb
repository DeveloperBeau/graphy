require_relative 'guard_number'

def hyp_cosh(x)
  value = guard_number(x)
  (Math.exp(value) + Math.exp(-value)) / 2.0
end
