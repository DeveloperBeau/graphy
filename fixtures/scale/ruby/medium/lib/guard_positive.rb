require_relative 'guard_number'

def guard_positive(x)
  value = guard_number(x)
  raise "must be positive" if value <= 0
  value
end
