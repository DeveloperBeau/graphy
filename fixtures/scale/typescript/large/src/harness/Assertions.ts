import { Errors } from '../util/Errors';
import { RunResult } from '../core/Pipeline';

export class Assertions {
  static assertOk(result: RunResult): boolean {
    if (!result.ok) throw Errors.roundtripFailed(result.name);
    return true;
  }

  static countOk(results: RunResult[]): number {
    return results.filter((r) => r.ok).length;
  }
}
