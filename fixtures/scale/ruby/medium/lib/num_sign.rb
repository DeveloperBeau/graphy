require_relative 'guard_number'

def num_sign(x)
  value = guard_number(x)
  value <=> 0
end
