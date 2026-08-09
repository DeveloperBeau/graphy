// Named calculator function: pow cbrt.
import { MathUtil } from '../mathutil';

export class PowCbrt {
  static apply(x: number): number {
    const value = MathUtil.guardPositive(x);
    return Math.cbrt(value);
  }
}
