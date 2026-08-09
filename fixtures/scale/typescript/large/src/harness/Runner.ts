import { Pipeline, RunResult } from '../core/Pipeline';
import { Cases } from './Cases';
import { Live } from '../report/Live';
import { Writer } from '../store/Writer';

export class Runner {
  static runAll(): RunResult[] {
    Live.emitBanner('starting');
    const results: RunResult[] = [];
    Writer.clearResult('session');
    for (const [name, text, key] of Cases.build()) {
      const result = Pipeline.roundTrip(name, text, key);
      const line = Live.emit(result);
      Writer.writeResult('session', line);
      results.push(result);
    }
    return results;
  }
}
