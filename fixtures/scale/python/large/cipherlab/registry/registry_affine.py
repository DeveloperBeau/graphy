from cipherlab.checks.check_affine import check_affine
from cipherlab.checks.check_decimation import check_decimation
from cipherlab.checks.check_promoter import check_promoter
from cipherlab.checks.check_modwheel import check_modwheel
from cipherlab.checks.check_linearmix import check_linearmix
from cipherlab.checks.check_skewmap import check_skewmap


def affine_checks():
    return [
        ("affine", check_affine),
        ("decimation", check_decimation),
        ("promoter", check_promoter),
        ("modwheel", check_modwheel),
        ("linearmix", check_linearmix),
        ("skewmap", check_skewmap),
    ]
