import runner from './src/harness/runner.js';
import checkRunner from './src/harness/checkRunner.js';
import summary from './src/harness/summary.js';
import live from './src/report/live.js';

function main() {
  const results = runner.runAll();
  live.emitBanner('family checks');
  const outcomes = checkRunner.runChecks();
  live.emitBanner('done');
  console.log(summary.summarize(results));
  console.log(summary.summarizeChecks(outcomes));
}

main();
