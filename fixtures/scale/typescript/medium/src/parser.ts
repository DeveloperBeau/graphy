import { Lexer } from './lexer';
import { Dispatch } from './dispatch';
import { Token } from './tokens';

export class Parser {
  static toRpn(text: string): Token[] {
    const out: Token[] = [];
    const stack: Token[] = [];
    for (const t of Lexer.tokenize(text)) {
      if (t.kind === 'NUMBER') out.push(t);
      else if (t.kind === 'OP') {
        while (stack.length && stack[stack.length - 1].kind === 'OP' &&
               Dispatch.precedence(String(stack[stack.length - 1].value)) >= Dispatch.precedence(String(t.value))) {
          out.push(stack.pop() as Token);
        }
        stack.push(t);
      } else if (t.kind === 'LPAREN') stack.push(t);
      else {
        while (stack.length && stack[stack.length - 1].kind !== 'LPAREN') out.push(stack.pop() as Token);
        stack.pop();
      }
    }
    while (stack.length) out.push(stack.pop() as Token);
    return out;
  }
}
