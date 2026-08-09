from cipherlab.checks.check_hexpack import check_hexpack
from cipherlab.checks.check_nibbleswap import check_nibbleswap
from cipherlab.checks.check_byteflip import check_byteflip
from cipherlab.checks.check_pairswap import check_pairswap
from cipherlab.checks.check_mirrorpack import check_mirrorpack
from cipherlab.checks.check_zigzagpack import check_zigzagpack
from cipherlab.checks.check_splitpack import check_splitpack
from cipherlab.checks.check_laddercode import check_laddercode
from cipherlab.checks.check_weavecode import check_weavecode
from cipherlab.checks.check_stridecode import check_stridecode


def codec_checks():
    return [
        ("hexpack", check_hexpack),
        ("nibbleswap", check_nibbleswap),
        ("byteflip", check_byteflip),
        ("pairswap", check_pairswap),
        ("mirrorpack", check_mirrorpack),
        ("zigzagpack", check_zigzagpack),
        ("splitpack", check_splitpack),
        ("laddercode", check_laddercode),
        ("weavecode", check_weavecode),
        ("stridecode", check_stridecode),
    ]
