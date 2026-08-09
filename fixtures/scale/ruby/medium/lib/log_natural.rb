require_relative 'guard_positive'

def log_natural(x)
  value = guard_positive(x)
  Math.log(value)
end
