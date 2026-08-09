require_relative 'guard_number'

def bi_minimum(a, b)
  left = guard_number(a)
  right = guard_number(b)
  [left, right].min
end
