// Named calculator function: trig tangent.
import { MathUtil } from '../mathutil';

export class TrigTangent {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return Math.tan(value);
  }
}
