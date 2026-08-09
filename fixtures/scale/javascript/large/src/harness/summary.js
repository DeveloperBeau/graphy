import assertions from './assertions.js';
import formatter from '../report/formatter.js';
import reader from '../store/reader.js';

function summarize(results) {
  const total = results.length;
  const passed = assertions.countOk(results);
  const logged = reader.countLines('session');
  return formatter.formatHeader() + '\n' + passed + '/' + total + ' passed, ' + logged + ' logged';
}

function summarizeChecks(outcomes) {
  const good = outcomes.filter(([, ok]) => ok).length;
  return good + '/' + outcomes.length + ' family checks passed';
}

export default { summarize, summarizeChecks };
