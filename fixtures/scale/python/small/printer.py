from banner import frame
from formatting import indent
from layout import render_page


def print_report(title, notes):
    print(frame(title))
    print(indent(notes, 4))


def print_page(text, width, theme):
    print(render_page(text, width, theme))
