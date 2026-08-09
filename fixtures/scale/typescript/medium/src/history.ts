import { Formatter } from './format';

export class History {
  private entries: string[] = [];

  record(expr: string, value: number): void {
    this.entries.push(Formatter.formatLine(expr, value));
  }

  dump(): string {
    return this.entries.join('\n');
  }
}
