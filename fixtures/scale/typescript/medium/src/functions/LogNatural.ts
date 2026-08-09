// Named calculator function: log natural.
import { MathUtil } from '../mathutil';

export class LogNatural {
  static apply(x: number): number {
    const value = MathUtil.guardPositive(x);
    return Math.log(value);
  }
}
