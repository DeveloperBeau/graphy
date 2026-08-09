export class MathUtil {
  static guardNumber(x: number): number {
    const value = Number(x);
    if (Number.isNaN(value)) throw new Error('not a number');
    return value;
  }

  static guardPositive(x: number): number {
    const value = MathUtil.guardNumber(x);
    if (value <= 0) throw new Error('must be positive');
    return value;
  }
}
