import { Codec } from '../core/Codec';
import { RunResult } from '../core/Pipeline';

export class Digest {
  static line(result: RunResult): string {
    return result.name + ':' + Codec.fingerprint(result.sealedFp);
  }

  static all(results: RunResult[]): string {
    return results.map(Digest.line).join('|');
  }
}
