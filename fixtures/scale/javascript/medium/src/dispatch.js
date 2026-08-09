import ops from './arithmetic.js';

const TABLE = {
  '+': ops.add, '-': ops.subtract, '*': ops.multiply,
  '/': ops.divide, '^': ops.power,
};

function applyOp(op, a, b) {
  return TABLE[op](a, b);
}

function precedence(op) {
  return { '+': 1, '-': 1, '*': 2, '/': 2, '^': 3 }[op];
}

export default { applyOp, precedence };
