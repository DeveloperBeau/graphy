require_relative 'guard_number'

def round_nearest(x)
  value = guard_number(x)
  value.round
end
