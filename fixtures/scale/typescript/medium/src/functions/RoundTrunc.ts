// Named calculator function: round trunc.
import { MathUtil } from '../mathutil';

export class RoundTrunc {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return Math.trunc(value);
  }
}
