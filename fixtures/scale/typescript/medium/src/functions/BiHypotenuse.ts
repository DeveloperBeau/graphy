// Named calculator function: bi hypotenuse.
import { MathUtil } from '../mathutil';

export class BiHypotenuse {
  static apply(a: number, b: number): number {
    const left = MathUtil.guardNumber(a);
    const right = MathUtil.guardNumber(b);
    return Math.sqrt(left * left + right * right);
  }
}
