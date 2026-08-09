def divide(a, b)
  raise "divide by zero" if b.zero?
  a.to_f / b
end
