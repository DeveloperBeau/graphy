require_relative 'guard_number'

def round_ceil(x)
  value = guard_number(x)
  value.ceil
end
