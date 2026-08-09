require_relative 'guard_number'

def num_absolute(x)
  value = guard_number(x)
  value.abs
end
