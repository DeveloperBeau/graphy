from cipherlab.checks.check_caesar import check_caesar
from cipherlab.checks.check_gronsfeld import check_gronsfeld
from cipherlab.checks.check_trithemius import check_trithemius
from cipherlab.checks.check_shiftreel import check_shiftreel
from cipherlab.checks.check_stairstep import check_stairstep
from cipherlab.checks.check_augustus import check_augustus
from cipherlab.checks.check_keypad import check_keypad
from cipherlab.checks.check_ordinal import check_ordinal


def additive_checks():
    return [
        ("caesar", check_caesar),
        ("gronsfeld", check_gronsfeld),
        ("trithemius", check_trithemius),
        ("shiftreel", check_shiftreel),
        ("stairstep", check_stairstep),
        ("augustus", check_augustus),
        ("keypad", check_keypad),
        ("ordinal", check_ordinal),
    ]
