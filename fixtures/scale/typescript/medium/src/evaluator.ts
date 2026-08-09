import { Parser } from './parser';
import { Dispatch } from './dispatch';

export class Evaluator {
  static evaluate(text: string): number {
    const stack: number[] = [];
    for (const t of Parser.toRpn(text)) {
      if (t.kind === 'NUMBER') stack.push(Number(t.value));
      else {
        const b = stack.pop() as number;
        const a = stack.pop() as number;
        stack.push(Dispatch.applyOp(String(t.value), a, b));
      }
    }
    return stack.pop() as number;
  }
}
