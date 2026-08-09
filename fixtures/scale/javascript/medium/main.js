import repl from './src/repl.js';
import funcs from './src/funcs.js';

function main() {
  const exprs = ['1 + 2 * 3', '(4 + 5) / 3', '2 ^ 8', '10 - 4 - 3'];
  const log = repl.runBatch(exprs);
  console.log('---');
  console.log(log.dump());
  console.log(funcs.applyNamed('trig_sine', [0.5]));
  console.log(funcs.applyNamed('bi_hypotenuse', [3, 4]));
}

main();
