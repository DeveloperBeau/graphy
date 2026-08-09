import { RoundFloor } from '../functions/RoundFloor';
import { RoundCeil } from '../functions/RoundCeil';
import { RoundNearest } from '../functions/RoundNearest';
import { RoundTrunc } from '../functions/RoundTrunc';
import { NumAbsolute } from '../functions/NumAbsolute';
import { NumSign } from '../functions/NumSign';

export class RegistryRound {
  static table(): Record<string, (...args: number[]) => number> {
    return {
      'round_floor': RoundFloor.apply,
      'round_ceil': RoundCeil.apply,
      'round_nearest': RoundNearest.apply,
      'round_trunc': RoundTrunc.apply,
      'num_absolute': NumAbsolute.apply,
      'num_sign': NumSign.apply,
    };
  }
}
