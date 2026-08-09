import { Repl } from './src/repl';
import { Funcs } from './src/funcs';

function main(): void {
  const exprs = ['1 + 2 * 3', '(4 + 5) / 3', '2 ^ 8', '10 - 4 - 3'];
  const log = Repl.runBatch(exprs);
  console.log('---');
  console.log(log.dump());
  console.log(Funcs.applyNamed('trig_sine', [0.5]));
  console.log(Funcs.applyNamed('bi_hypotenuse', [3, 4]));
}

main();
