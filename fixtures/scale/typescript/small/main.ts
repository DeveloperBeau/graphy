import { Printer } from './printer';
import { Casing } from './casing';

function main(): void {
  Printer.printReport(Casing.title('weekly status'));
  Printer.printPage('the quick brown fox jumps over the lazy dog', 24, 'plain');
}

main();
