export class Arithmetic {
  static add(a: number, b: number): number {
    return a + b;
  }

  static subtract(a: number, b: number): number {
    return a - b;
  }

  static multiply(a: number, b: number): number {
    return a * b;
  }

  static divide(a: number, b: number): number {
    if (b === 0) throw new Error('divide by zero');
    return a / b;
  }

  static power(a: number, b: number): number {
    return Math.pow(a, b);
  }
}
