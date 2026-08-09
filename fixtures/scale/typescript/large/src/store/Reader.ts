import * as fs from 'fs';
import { Paths } from './Paths';

export class Reader {
  static readResult(name: string): string[] {
    const p = Paths.resultPath(name);
    if (!fs.existsSync(p)) return [];
    return fs.readFileSync(p, 'utf8').split('\n').filter((l) => l.length > 0);
  }

  static countLines(name: string): number {
    return Reader.readResult(name).length;
  }
}
