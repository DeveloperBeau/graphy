import { LogNatural } from '../functions/LogNatural';
import { LogCommon } from '../functions/LogCommon';
import { LogBinary } from '../functions/LogBinary';
import { PowSqrt } from '../functions/PowSqrt';
import { PowCbrt } from '../functions/PowCbrt';
import { PowSquare } from '../functions/PowSquare';
import { PowCube } from '../functions/PowCube';
import { PowExp } from '../functions/PowExp';

export class RegistryLogs {
  static table(): Record<string, (...args: number[]) => number> {
    return {
      'log_natural': LogNatural.apply,
      'log_common': LogCommon.apply,
      'log_binary': LogBinary.apply,
      'pow_sqrt': PowSqrt.apply,
      'pow_cbrt': PowCbrt.apply,
      'pow_square': PowSquare.apply,
      'pow_cube': PowCube.apply,
      'pow_exp': PowExp.apply,
    };
  }
}
