// Named calculator function: trig cosine.
import { MathUtil } from '../mathutil';

export class TrigCosine {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return Math.cos(value);
  }
}
