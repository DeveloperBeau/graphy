// Named calculator function: hyp cosh.
import { MathUtil } from '../mathutil';

export class HypCosh {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return (Math.exp(value) + Math.exp(-value)) / 2;
  }
}
