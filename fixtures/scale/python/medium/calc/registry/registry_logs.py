from calc.functions.log_natural import log_natural
from calc.functions.log_common import log_common
from calc.functions.log_binary import log_binary
from calc.functions.pow_sqrt import pow_sqrt
from calc.functions.pow_cbrt import pow_cbrt
from calc.functions.pow_square import pow_square
from calc.functions.pow_cube import pow_cube
from calc.functions.pow_exp import pow_exp


def logs_table():
    return {
        "log_natural": log_natural,
        "log_common": log_common,
        "log_binary": log_binary,
        "pow_sqrt": pow_sqrt,
        "pow_cbrt": pow_cbrt,
        "pow_square": pow_square,
        "pow_cube": pow_cube,
        "pow_exp": pow_exp,
    }
