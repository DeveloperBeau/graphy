import { Runner } from './src/harness/Runner';
import { CheckRunner } from './src/harness/CheckRunner';
import { Summary } from './src/harness/Summary';
import { Live } from './src/report/Live';

function main(): void {
  const results = Runner.runAll();
  Live.emitBanner('family checks');
  const outcomes = CheckRunner.runChecks();
  Live.emitBanner('done');
  console.log(Summary.summarize(results));
  console.log(Summary.summarizeChecks(outcomes));
}

main();
