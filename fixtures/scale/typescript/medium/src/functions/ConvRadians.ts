// Named calculator function: conv radians.
import { MathUtil } from '../mathutil';

export class ConvRadians {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return value * Math.PI / 180;
  }
}
