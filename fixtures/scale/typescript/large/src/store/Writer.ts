import * as fs from 'fs';
import { Paths } from './Paths';

export class Writer {
  static ensureDir(): void {
    fs.mkdirSync(Paths.storeDir(), { recursive: true });
  }

  static writeResult(name: string, line: string): void {
    Writer.ensureDir();
    fs.appendFileSync(Paths.resultPath(name), line + '\n');
  }

  static clearResult(name: string): void {
    Writer.ensureDir();
    fs.writeFileSync(Paths.resultPath(name), '');
  }
}
