import sys
from cipherlab.report.formatter import format_row


def emit(result):
    line = format_row(result)
    sys.stdout.write(line + "\n")
    sys.stdout.flush()
    return line


def emit_banner(text):
    sys.stdout.write("--- " + text + " ---\n")
    sys.stdout.flush()
