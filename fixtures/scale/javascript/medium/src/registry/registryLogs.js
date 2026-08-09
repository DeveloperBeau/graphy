import logNatural from '../functions/logNatural.js';
import logCommon from '../functions/logCommon.js';
import logBinary from '../functions/logBinary.js';
import powSqrt from '../functions/powSqrt.js';
import powCbrt from '../functions/powCbrt.js';
import powSquare from '../functions/powSquare.js';
import powCube from '../functions/powCube.js';
import powExp from '../functions/powExp.js';

function logsTable() {
  return {
    'log_natural': logNatural.logNatural,
    'log_common': logCommon.logCommon,
    'log_binary': logBinary.logBinary,
    'pow_sqrt': powSqrt.powSqrt,
    'pow_cbrt': powCbrt.powCbrt,
    'pow_square': powSquare.powSquare,
    'pow_cube': powCube.powCube,
    'pow_exp': powExp.powExp,
  };
}

export default { logsTable };
