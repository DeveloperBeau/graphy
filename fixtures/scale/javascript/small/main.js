import printer from './printer.js';
import casing from './casing.js';

function main() {
  printer.printReport(casing.titleCase('weekly status'));
  printer.printPage('the quick brown fox jumps over the lazy dog', 24, 'plain');
}

main();
