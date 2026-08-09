from wrap import wrap_text
from align import align_center
from pad import pad_lines
from border import border_top, border_side
from width import max_width


def render_page(text, width, theme):
    lines = wrap_text(text, width)
    body = max_width(lines)
    centered = [align_center(line, body) for line in pad_lines(lines, 1)]
    top = border_top(body, theme)
    sides = [border_side(line, body, theme) for line in centered]
    return "\n".join([top] + sides + [top])
