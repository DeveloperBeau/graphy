require_relative 'token_of'
require_relative 'is_operator'

def tokenize(text)
  tokens = []
  i = 0
  while i < text.length
    ch = text[i]
    if ch == " "
      i += 1
    elsif ch =~ /[0-9.]/
      j = i
      j += 1 while j < text.length && text[j] =~ /[0-9.]/
      tokens << token_of(:number, text[i...j].to_f)
      i = j
    elsif is_operator(ch)
      tokens << token_of(:op, ch)
      i += 1
    else
      i += 1
    end
  end
  tokens
end
