import { RunResult } from '../core/Pipeline';

export class Formatter {
  static formatRow(result: RunResult): string {
    const status = result.ok ? 'OK ' : 'BAD';
    return status + ' ' + result.name.padEnd(12) + ' fp=' + result.sealedFp + ' ' + result.ms + 'ms';
  }

  static formatHeader(): string {
    return '=== cipher round-trip report ===';
  }

  static formatCheck(name: string, ok: boolean): string {
    return (ok ? 'PASS' : 'FAIL') + ' check ' + name;
  }
}
