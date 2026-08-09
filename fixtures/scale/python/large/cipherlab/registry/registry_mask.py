from cipherlab.checks.check_xorkey import check_xorkey
from cipherlab.checks.check_maskbyte import check_maskbyte
from cipherlab.checks.check_paritymix import check_paritymix
from cipherlab.checks.check_bitfold import check_bitfold
from cipherlab.checks.check_veilmask import check_veilmask
from cipherlab.checks.check_dualmask import check_dualmask
from cipherlab.checks.check_nibblexor import check_nibblexor
from cipherlab.checks.check_staticpad import check_staticpad


def mask_checks():
    return [
        ("xorkey", check_xorkey),
        ("maskbyte", check_maskbyte),
        ("paritymix", check_paritymix),
        ("bitfold", check_bitfold),
        ("veilmask", check_veilmask),
        ("dualmask", check_dualmask),
        ("nibblexor", check_nibblexor),
        ("staticpad", check_staticpad),
    ]
