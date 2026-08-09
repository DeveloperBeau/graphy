// Named calculator function: pow sqrt.
import { MathUtil } from '../mathutil';

export class PowSqrt {
  static apply(x: number): number {
    const value = MathUtil.guardPositive(x);
    return Math.sqrt(value);
  }
}
