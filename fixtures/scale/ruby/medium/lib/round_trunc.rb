require_relative 'guard_number'

def round_trunc(x)
  value = guard_number(x)
  value.truncate
end
