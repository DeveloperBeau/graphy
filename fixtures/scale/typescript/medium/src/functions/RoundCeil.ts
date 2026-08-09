// Named calculator function: round ceil.
import { MathUtil } from '../mathutil';

export class RoundCeil {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return Math.ceil(value);
  }
}
