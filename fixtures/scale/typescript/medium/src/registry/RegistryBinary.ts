import { BiArctangent } from '../functions/BiArctangent';
import { BiRemainder } from '../functions/BiRemainder';
import { BiMaximum } from '../functions/BiMaximum';
import { BiMinimum } from '../functions/BiMinimum';
import { BiHypotenuse } from '../functions/BiHypotenuse';

export class RegistryBinary {
  static table(): Record<string, (...args: number[]) => number> {
    return {
      'bi_arctangent': BiArctangent.apply,
      'bi_remainder': BiRemainder.apply,
      'bi_maximum': BiMaximum.apply,
      'bi_minimum': BiMinimum.apply,
      'bi_hypotenuse': BiHypotenuse.apply,
    };
  }
}
