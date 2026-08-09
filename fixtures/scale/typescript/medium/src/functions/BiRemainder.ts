// Named calculator function: bi remainder.
import { MathUtil } from '../mathutil';

export class BiRemainder {
  static apply(a: number, b: number): number {
    const left = MathUtil.guardNumber(a);
    const right = MathUtil.guardNumber(b);
    return left % right;
  }
}
