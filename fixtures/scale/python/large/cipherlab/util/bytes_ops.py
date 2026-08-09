def to_codes(text):
    return [ord(ch) for ch in text]


def from_codes(codes):
    return "".join(chr(c % 256) for c in codes)


def rotate_left(codes, n):
    return codes[n:] + codes[:n]


def xor_stream(codes, key_codes):
    out = []
    for i, c in enumerate(codes):
        out.append(c ^ key_codes[i % len(key_codes)])
    return out
