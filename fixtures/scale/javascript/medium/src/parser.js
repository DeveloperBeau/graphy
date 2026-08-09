import lexer from './lexer.js';
import dispatch from './dispatch.js';
import tok from './tokens.js';

function toRpn(text) {
  const out = [];
  const stack = [];
  for (const t of lexer.tokenize(text)) {
    if (t.kind === tok.NUMBER) out.push(t);
    else if (t.kind === tok.OP) {
      while (stack.length && stack[stack.length - 1].kind === tok.OP &&
             dispatch.precedence(stack[stack.length - 1].value) >= dispatch.precedence(t.value)) {
        out.push(stack.pop());
      }
      stack.push(t);
    } else if (t.kind === tok.LPAREN) stack.push(t);
    else if (t.kind === tok.RPAREN) {
      while (stack.length && stack[stack.length - 1].kind !== tok.LPAREN) out.push(stack.pop());
      stack.pop();
    }
  }
  while (stack.length) out.push(stack.pop());
  return out;
}

export default { toRpn };
