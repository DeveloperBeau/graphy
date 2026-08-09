// Named calculator function: conv fahrenheit.
import { MathUtil } from '../mathutil';

export class ConvFahrenheit {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return value * 9 / 5 + 32;
  }
}
