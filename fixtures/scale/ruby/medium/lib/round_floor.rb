require_relative 'guard_number'

def round_floor(x)
  value = guard_number(x)
  value.floor
end
