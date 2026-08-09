// Named calculator function: bi maximum.
import { MathUtil } from '../mathutil';

export class BiMaximum {
  static apply(a: number, b: number): number {
    const left = MathUtil.guardNumber(a);
    const right = MathUtil.guardNumber(b);
    return Math.max(left, right);
  }
}
