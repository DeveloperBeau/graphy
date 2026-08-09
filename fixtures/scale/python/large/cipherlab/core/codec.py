def to_hex(text):
    return "".join("{:02x}".format(ord(ch) % 256) for ch in text)


def from_hex(hexstr):
    pairs = [hexstr[i:i + 2] for i in range(0, len(hexstr), 2)]
    return "".join(chr(int(p, 16)) for p in pairs)


def fingerprint(text):
    total = sum(ord(ch) for ch in text)
    return "{:04x}".format(total % 65536)
