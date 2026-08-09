export type TokenKind = 'NUMBER' | 'OP' | 'LPAREN' | 'RPAREN';

export interface Token {
  kind: TokenKind;
  value: number | string;
}

export class Tokens {
  static make(kind: TokenKind, value: number | string): Token {
    return { kind, value };
  }

  static isOperator(ch: string): boolean {
    return '+-*/^'.includes(ch);
  }
}
