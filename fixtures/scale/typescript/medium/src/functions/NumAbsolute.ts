// Named calculator function: num absolute.
import { MathUtil } from '../mathutil';

export class NumAbsolute {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return Math.abs(value);
  }
}
