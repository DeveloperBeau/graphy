// Named calculator function: round floor.
import { MathUtil } from '../mathutil';

export class RoundFloor {
  static apply(x: number): number {
    const value = MathUtil.guardNumber(x);
    return Math.floor(value);
  }
}
