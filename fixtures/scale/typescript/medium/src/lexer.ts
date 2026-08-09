import { Tokens, Token } from './tokens';

export class Lexer {
  static tokenize(text: string): Token[] {
    const tokens: Token[] = [];
    let i = 0;
    while (i < text.length) {
      const ch = text[i];
      if (ch === ' ') { i += 1; continue; }
      if (ch >= '0' && ch <= '9') {
        let j = i;
        while (j < text.length && /[0-9.]/.test(text[j])) j += 1;
        tokens.push(Tokens.make('NUMBER', parseFloat(text.slice(i, j))));
        i = j;
      } else if (ch === '(') { tokens.push(Tokens.make('LPAREN', ch)); i += 1; }
      else if (ch === ')') { tokens.push(Tokens.make('RPAREN', ch)); i += 1; }
      else if (Tokens.isOperator(ch)) { tokens.push(Tokens.make('OP', ch)); i += 1; }
      else { throw new Error('bad char ' + ch); }
    }
    return tokens;
  }
}
