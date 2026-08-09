// Named calculator function: bi arctangent.
import { MathUtil } from '../mathutil';

export class BiArctangent {
  static apply(a: number, b: number): number {
    const left = MathUtil.guardNumber(a);
    const right = MathUtil.guardNumber(b);
    return Math.atan2(left, right);
  }
}
