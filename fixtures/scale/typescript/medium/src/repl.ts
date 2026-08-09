import { Evaluator } from './evaluator';
import { History } from './history';
import { Formatter } from './format';

export class Repl {
  static runBatch(expressions: string[]): History {
    const log = new History();
    for (const expr of expressions) {
      const value = Evaluator.evaluate(expr);
      log.record(expr, value);
      console.log(Formatter.formatLine(expr, value));
    }
    return log;
  }
}
