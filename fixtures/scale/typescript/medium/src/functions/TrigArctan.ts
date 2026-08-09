// Named calculator function: trig arctan.
import { MathUtil } from '../mathutil';

export class TrigArctan {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return Math.atan(value);
  }
}
