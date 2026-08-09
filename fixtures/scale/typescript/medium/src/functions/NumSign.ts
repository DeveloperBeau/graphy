// Named calculator function: num sign.
import { MathUtil } from '../mathutil';

export class NumSign {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return Math.sign(value);
  }
}
