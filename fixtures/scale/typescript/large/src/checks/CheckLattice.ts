import { Lattice } from '../ciphers/Lattice';
import { LatticeSpec } from '../specs/LatticeSpec';
import { CorpusRotate } from '../corpus/CorpusRotate';

export class CheckLattice {
  static run(): boolean {
    const spec = LatticeSpec.get();
    for (const text of CorpusRotate.texts()) {
      const sealed = Lattice.encrypt(text, spec.key);
      const opened = Lattice.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'rotate';
  }
}
