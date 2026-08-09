import evaluator from './evaluator.js';
import format from './format.js';
import { History } from './history.js';

function runBatch(expressions) {
  const log = new History();
  for (const expr of expressions) {
    const value = evaluator.evaluate(expr);
    log.record(expr, value);
    console.log(format.formatLine(expr, value));
  }
  return log;
}

export default { runBatch };
