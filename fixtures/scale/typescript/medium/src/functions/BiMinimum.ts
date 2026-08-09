// Named calculator function: bi minimum.
import { MathUtil } from '../mathutil';

export class BiMinimum {
  static apply(a: number, b: number): number {
    const left = MathUtil.guardNumber(a);
    const right = MathUtil.guardNumber(b);
    return Math.min(left, right);
  }
}
