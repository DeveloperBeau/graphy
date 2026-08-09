require_relative 'wrap_text'
require_relative 'align_center'
require_relative 'max_width'

def render_page(text, cols)
  lines = wrap_text(text, cols)
  body = max_width(lines)
  centered = lines.map { |l| align_center(l, body) }
  centered.join("\n")
end
