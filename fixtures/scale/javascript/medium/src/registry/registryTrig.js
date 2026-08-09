import trigSine from '../functions/trigSine.js';
import trigCosine from '../functions/trigCosine.js';
import trigTangent from '../functions/trigTangent.js';
import trigArctan from '../functions/trigArctan.js';
import hypSinh from '../functions/hypSinh.js';
import hypCosh from '../functions/hypCosh.js';
import hypTanh from '../functions/hypTanh.js';

function trigTable() {
  return {
    'trig_sine': trigSine.trigSine,
    'trig_cosine': trigCosine.trigCosine,
    'trig_tangent': trigTangent.trigTangent,
    'trig_arctan': trigArctan.trigArctan,
    'hyp_sinh': hypSinh.hypSinh,
    'hyp_cosh': hypCosh.hypCosh,
    'hyp_tanh': hypTanh.hypTanh,
  };
}

export default { trigTable };
