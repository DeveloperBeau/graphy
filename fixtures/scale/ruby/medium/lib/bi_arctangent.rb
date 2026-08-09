require_relative 'guard_number'

def bi_arctangent(a, b)
  left = guard_number(a)
  right = guard_number(b)
  Math.atan2(left, right)
end
