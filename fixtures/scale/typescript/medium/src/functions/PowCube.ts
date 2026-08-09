// Named calculator function: pow cube.
import { MathUtil } from '../mathutil';

export class PowCube {
  static apply(x: number): number {
    const value = MathUtil.guardPositive(x);
    return value * value * value;
  }
}
