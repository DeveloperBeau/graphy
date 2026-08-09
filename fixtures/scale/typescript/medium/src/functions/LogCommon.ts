// Named calculator function: log common.
import { MathUtil } from '../mathutil';

export class LogCommon {
  static apply(x: number): number {
    const value = MathUtil.guardPositive(x);
    return Math.log10(value);
  }
}
