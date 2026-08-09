// Named calculator function: log binary.
import { MathUtil } from '../mathutil';

export class LogBinary {
  static apply(x: number): number {
    const value = MathUtil.guardPositive(x);
    return Math.log2(value);
  }
}
