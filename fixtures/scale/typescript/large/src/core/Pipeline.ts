import { Registry } from './Registry';
import { Codec } from './Codec';
import { Timing } from '../util/Timing';

export interface RunResult {
  name: string;
  ok: boolean;
  sealedFp: string;
  ms: number;
}

export class Pipeline {
  static roundTrip(name: string, text: string, key: number): RunResult {
    const [encrypt, decrypt] = Registry.getCipher(name);
    const start = Timing.nowMs();
    const sealed = encrypt(text, key);
    const opened = decrypt(sealed, key);
    return { name, ok: opened === text, sealedFp: Codec.fingerprint(sealed), ms: Timing.elapsed(start) };
  }
}
