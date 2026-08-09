def precedence(op)
  levels = { "+" => 1, "-" => 1, "*" => 2, "/" => 2, "^" => 3 }
  levels.fetch(op, 0)
end
