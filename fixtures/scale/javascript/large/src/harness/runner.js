import pipeline from '../core/pipeline.js';
import cases from './cases.js';
import live from '../report/live.js';
import writer from '../store/writer.js';

function runAll() {
  live.emitBanner('starting');
  const results = [];
  writer.clearResult('session');
  for (const [name, text, key] of cases.buildCases()) {
    const result = pipeline.roundTrip(name, text, key);
    const line = live.emit(result);
    writer.writeResult('session', line);
    results.push(result);
  }
  return results;
}

export default { runAll };
