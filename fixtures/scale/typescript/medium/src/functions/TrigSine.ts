// Named calculator function: trig sine.
import { MathUtil } from '../mathutil';

export class TrigSine {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return Math.sin(value);
  }
}
