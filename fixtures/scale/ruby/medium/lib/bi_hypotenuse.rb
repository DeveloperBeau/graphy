require_relative 'guard_number'

def bi_hypotenuse(a, b)
  left = guard_number(a)
  right = guard_number(b)
  Math.sqrt(left * left + right * right)
end
