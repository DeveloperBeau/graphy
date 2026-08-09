def guard_number(x)
  value = x.to_f
  raise "not a number" if value.nan?
  value
end
