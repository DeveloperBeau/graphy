from cipherlab.checks.check_blockrotate import check_blockrotate
from cipherlab.checks.check_ringshift import check_ringshift
from cipherlab.checks.check_carousel import check_carousel
from cipherlab.checks.check_conveyor import check_conveyor
from cipherlab.checks.check_turnstile import check_turnstile
from cipherlab.checks.check_windmill import check_windmill
from cipherlab.checks.check_ferris import check_ferris
from cipherlab.checks.check_lattice import check_lattice


def rotate_checks():
    return [
        ("blockrotate", check_blockrotate),
        ("ringshift", check_ringshift),
        ("carousel", check_carousel),
        ("conveyor", check_conveyor),
        ("turnstile", check_turnstile),
        ("windmill", check_windmill),
        ("ferris", check_ferris),
        ("lattice", check_lattice),
    ]
