import { RegistryAdditive } from '../registry/RegistryAdditive';
import { RegistryAffine } from '../registry/RegistryAffine';
import { RegistryMask } from '../registry/RegistryMask';
import { RegistryStream } from '../registry/RegistryStream';
import { RegistryRotate } from '../registry/RegistryRotate';
import { RegistryHash } from '../registry/RegistryHash';
import { RegistryCodec } from '../registry/RegistryCodec';
import { Formatter } from '../report/Formatter';
import { Writer } from '../store/Writer';

export class CheckRunner {
  static runChecks(): Array<[string, boolean]> {
    const outcomes: Array<[string, boolean]> = [];
    const all: Array<[string, () => boolean]> = [...RegistryAdditive.checks(), ...RegistryAffine.checks(), ...RegistryMask.checks(), ...RegistryStream.checks(), ...RegistryRotate.checks(), ...RegistryHash.checks(), ...RegistryCodec.checks()];
    for (const [name, check] of all) {
      const ok = check();
      Writer.writeResult('checks', Formatter.formatCheck(name, ok));
      outcomes.push([name, ok]);
    }
    return outcomes;
  }
}
