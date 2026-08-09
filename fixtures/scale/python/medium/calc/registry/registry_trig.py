from calc.functions.trig_sine import trig_sine
from calc.functions.trig_cosine import trig_cosine
from calc.functions.trig_tangent import trig_tangent
from calc.functions.trig_arctan import trig_arctan
from calc.functions.hyp_sinh import hyp_sinh
from calc.functions.hyp_cosh import hyp_cosh
from calc.functions.hyp_tanh import hyp_tanh


def trig_table():
    return {
        "trig_sine": trig_sine,
        "trig_cosine": trig_cosine,
        "trig_tangent": trig_tangent,
        "trig_arctan": trig_arctan,
        "hyp_sinh": hyp_sinh,
        "hyp_cosh": hyp_cosh,
        "hyp_tanh": hyp_tanh,
    }
