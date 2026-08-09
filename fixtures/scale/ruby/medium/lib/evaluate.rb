require_relative 'to_rpn'
require_relative 'apply_op'

def evaluate(text)
  stack = []
  to_rpn(text).each do |tok|
    if tok[:kind] == :number
      stack << tok[:value]
    else
      b = stack.pop
      a = stack.pop
      stack << apply_op(tok[:value], a, b)
    end
  end
  stack.pop
end
