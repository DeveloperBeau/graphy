require_relative 'print_report'
require_relative 'render_page'
require_relative 'title_case'

def run
  print_report(title_case("weekly status"))
  puts render_page("the quick brown fox jumps over the lazy dog", 24)
end

run
