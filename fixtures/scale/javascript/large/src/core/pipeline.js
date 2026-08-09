import registry from './registry.js';
import codec from './codec.js';
import timing from '../util/timing.js';

function roundTrip(name, text, key) {
  const [encrypt, decrypt] = registry.getCipher(name);
  const start = timing.nowMs();
  const sealed = encrypt(text, key);
  const opened = decrypt(sealed, key);
  return {
    name,
    ok: opened === text,
    sealedFp: codec.fingerprint(sealed),
    ms: timing.elapsed(start),
  };
}

export default { roundTrip };
