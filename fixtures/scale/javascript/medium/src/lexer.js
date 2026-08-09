import tok from './tokens.js';

function tokenize(text) {
  const tokens = [];
  let i = 0;
  while (i < text.length) {
    const ch = text[i];
    if (ch === ' ') { i += 1; continue; }
    if (ch >= '0' && ch <= '9') {
      let j = i;
      while (j < text.length && /[0-9.]/.test(text[j])) j += 1;
      tokens.push(tok.makeToken(tok.NUMBER, parseFloat(text.slice(i, j))));
      i = j;
    } else if (ch === '(') { tokens.push(tok.makeToken(tok.LPAREN, ch)); i += 1; }
    else if (ch === ')') { tokens.push(tok.makeToken(tok.RPAREN, ch)); i += 1; }
    else if (tok.isOperator(ch)) { tokens.push(tok.makeToken(tok.OP, ch)); i += 1; }
    else { throw new Error('bad char ' + ch); }
  }
  return tokens;
}

export default { tokenize };
