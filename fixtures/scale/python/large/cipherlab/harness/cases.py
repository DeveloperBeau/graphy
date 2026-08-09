def sample_texts():
    return ["attack at dawn", "the quick brown fox", "hello world"]


def sample_keys():
    return {"caesar": 7, "xorkey": 3, "lcgstream": 11, "carousel": 5}


def build_cases():
    keys = sample_keys()
    return [(name, text, keys[name]) for name in keys for text in sample_texts()]
