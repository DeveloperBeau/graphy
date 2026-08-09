def visible_len(line):
    return len(line.rstrip())


def max_width(lines):
    if not lines:
        return 0
    return max(visible_len(line) for line in lines)
