// Named calculator function: conv degrees.
import { MathUtil } from '../mathutil';

export class ConvDegrees {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return value * 180 / Math.PI;
  }
}
