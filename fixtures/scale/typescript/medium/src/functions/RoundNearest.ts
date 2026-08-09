// Named calculator function: round nearest.
import { MathUtil } from '../mathutil';

export class RoundNearest {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return Math.round(value);
  }
}
