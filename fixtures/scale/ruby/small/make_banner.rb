require_relative 'upcase_title'
require_relative 'underline'

def make_banner(title)
  loud = upcase_title(title)
  underline(loud)
end
