import parser from './parser.js';
import dispatch from './dispatch.js';
import tok from './tokens.js';

function evaluate(text) {
  const stack = [];
  for (const t of parser.toRpn(text)) {
    if (t.kind === tok.NUMBER) stack.push(t.value);
    else {
      const b = stack.pop();
      const a = stack.pop();
      stack.push(dispatch.applyOp(t.value, a, b));
    }
  }
  return stack.pop();
}

export default { evaluate };
