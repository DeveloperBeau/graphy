from calc.functions.round_floor import round_floor
from calc.functions.round_ceil import round_ceil
from calc.functions.round_nearest import round_nearest
from calc.functions.round_trunc import round_trunc
from calc.functions.num_absolute import num_absolute
from calc.functions.num_sign import num_sign


def round_table():
    return {
        "round_floor": round_floor,
        "round_ceil": round_ceil,
        "round_nearest": round_nearest,
        "round_trunc": round_trunc,
        "num_absolute": num_absolute,
        "num_sign": num_sign,
    }
