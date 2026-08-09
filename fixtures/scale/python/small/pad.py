def pad_lines(lines, count):
    blank = ""
    return [blank] * count + lines + [blank] * count


def pad_width(lines, width):
    return [line.ljust(width) for line in lines]
