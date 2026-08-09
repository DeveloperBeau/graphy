require_relative 'guard_number'

def hyp_tanh(x)
  value = guard_number(x)
  (Math.exp(2 * value) - 1) / (Math.exp(2 * value) + 1)
end
