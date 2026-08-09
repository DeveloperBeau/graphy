// Named calculator function: hyp sinh.
import { MathUtil } from '../mathutil';

export class HypSinh {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return (Math.exp(value) - Math.exp(-value)) / 2;
  }
}
