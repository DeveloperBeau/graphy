import { RegistryTrig } from './registry/RegistryTrig';
import { RegistryLogs } from './registry/RegistryLogs';
import { RegistryRound } from './registry/RegistryRound';
import { RegistryConvert } from './registry/RegistryConvert';
import { RegistryBinary } from './registry/RegistryBinary';

export class Funcs {
  static fullTable(): Record<string, (...args: number[]) => number> {
    return {
      ...RegistryTrig.table(),
      ...RegistryLogs.table(),
      ...RegistryRound.table(),
      ...RegistryConvert.table(),
      ...RegistryBinary.table(),
    };
  }

  static applyNamed(name: string, args: number[]): number {
    const fn = Funcs.fullTable()[name];
    return fn(...args);
  }
}
