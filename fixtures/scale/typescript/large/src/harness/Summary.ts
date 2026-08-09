import { Assertions } from './Assertions';
import { Formatter } from '../report/Formatter';
import { Reader } from '../store/Reader';
import { RunResult } from '../core/Pipeline';

export class Summary {
  static summarize(results: RunResult[]): string {
    const total = results.length;
    const passed = Assertions.countOk(results);
    const logged = Reader.countLines('session');
    return Formatter.formatHeader() + '\n' + passed + '/' + total + ' passed, ' + logged + ' logged';
  }

  static summarizeChecks(outcomes: Array<[string, boolean]>): string {
    const good = outcomes.filter(([, ok]) => ok).length;
    return good + '/' + outcomes.length + ' family checks passed';
  }
}
