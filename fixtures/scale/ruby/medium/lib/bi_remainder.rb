require_relative 'guard_number'

def bi_remainder(a, b)
  left = guard_number(a)
  right = guard_number(b)
  left % right
end
