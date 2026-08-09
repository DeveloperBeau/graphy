require_relative 'guard_number'

def bi_maximum(a, b)
  left = guard_number(a)
  right = guard_number(b)
  [left, right].max
end
