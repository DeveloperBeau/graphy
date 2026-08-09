def wrap_text(text, width):
    words = text.split()
    lines = []
    current = ""
    for word in words:
        if len(current) + len(word) + 1 > width:
            lines.append(current.strip())
            current = ""
        current += word + " "
    if current.strip():
        lines.append(current.strip())
    return lines
