require_relative 'guard_positive'

def log_common(x)
  value = guard_positive(x)
  Math.log10(value)
end
