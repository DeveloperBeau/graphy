// Named calculator function: hyp tanh.
import { MathUtil } from '../mathutil';

export class HypTanh {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return (Math.exp(2 * value) - 1) / (Math.exp(2 * value) + 1);
  }
}
