require_relative 'tokenize'
require_relative 'precedence'

def to_rpn(text)
  out = []
  stack = []
  tokenize(text).each do |tok|
    if tok[:kind] == :number
      out << tok
    else
      while stack.last && precedence(stack.last[:value]) >= precedence(tok[:value])
        out << stack.pop
      end
      stack << tok
    end
  end
  out << stack.pop while stack.any?
  out
end
