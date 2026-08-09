import { Arithmetic } from './arithmetic';

export class Dispatch {
  static applyOp(op: string, a: number, b: number): number {
    const table: Record<string, (x: number, y: number) => number> = {
      '+': Arithmetic.add,
      '-': Arithmetic.subtract,
      '*': Arithmetic.multiply,
      '/': Arithmetic.divide,
      '^': Arithmetic.power,
    };
    return table[op](a, b);
  }

  static precedence(op: string): number {
    return { '+': 1, '-': 1, '*': 2, '/': 2, '^': 3 }[op] ?? 0;
  }
}
