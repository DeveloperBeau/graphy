def title_case(text):
    return " ".join(word.capitalize() for word in text.split())


def shout_case(text):
    return text.upper() + "!"
