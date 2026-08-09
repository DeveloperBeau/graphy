require_relative 'make_banner'
require_relative 'repeat_char'

def boxed(title)
  bar = repeat_char("*", 30)
  [bar, make_banner(title), bar].join("\n")
end
