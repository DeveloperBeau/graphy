// Named calculator function: pow square.
import { MathUtil } from '../mathutil';

export class PowSquare {
  static apply(x: number): number {
    const value = MathUtil.guardPositive(x);
    return value * value;
  }
}
