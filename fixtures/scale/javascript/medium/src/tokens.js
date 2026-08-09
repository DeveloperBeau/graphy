const NUMBER = 'NUMBER';
const OP = 'OP';
const LPAREN = 'LPAREN';
const RPAREN = 'RPAREN';

function makeToken(kind, value) {
  return { kind, value };
}

function isOperator(ch) {
  return '+-*/^'.includes(ch);
}

export default { NUMBER, OP, LPAREN, RPAREN, makeToken, isOperator };
