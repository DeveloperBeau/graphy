import * as path from 'path';

export class Paths {
  static storeDir(): string {
    return path.join(process.cwd(), 'runs');
  }

  static resultPath(name: string): string {
    return path.join(Paths.storeDir(), name + '.log');
  }
}
