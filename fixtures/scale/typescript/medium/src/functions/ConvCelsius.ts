// Named calculator function: conv celsius.
import { MathUtil } from '../mathutil';

export class ConvCelsius {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return (value - 32) * 5 / 9;
  }
}
