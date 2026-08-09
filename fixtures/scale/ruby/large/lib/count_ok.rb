def count_ok(results)
  results.count { |r| r[:ok] }
end
