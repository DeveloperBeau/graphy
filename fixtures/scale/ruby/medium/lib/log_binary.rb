require_relative 'guard_positive'

def log_binary(x)
  value = guard_positive(x)
  Math.log2(value)
end
