require_relative 'guard_number'

def trig_cosine(x)
  value = guard_number(x)
  Math.cos(value)
end
