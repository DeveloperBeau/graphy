import { Formatter } from './Formatter';
import { RunResult } from '../core/Pipeline';

export class Live {
  static emit(result: RunResult): string {
    const line = Formatter.formatRow(result);
    process.stdout.write(line + '\n');
    return line;
  }

  static emitBanner(text: string): void {
    process.stdout.write('--- ' + text + ' ---\n');
  }
}
