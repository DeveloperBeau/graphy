// Named calculator function: pow exp.
import { MathUtil } from '../mathutil';

export class PowExp {
  static apply(x: number): number {
    const value = MathUtil.guardPositive(x);
    return Math.exp(value);
  }
}
