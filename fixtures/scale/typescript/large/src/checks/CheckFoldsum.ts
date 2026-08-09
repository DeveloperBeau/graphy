import { Foldsum } from '../ciphers/Foldsum';
import { FoldsumSpec } from '../specs/FoldsumSpec';
import { CorpusHash } from '../corpus/CorpusHash';

export class CheckFoldsum {
  static run(): boolean {
    const spec = FoldsumSpec.get();
    for (const text of CorpusHash.texts()) {
      const first = Foldsum.digest(text);
      const second = Foldsum.digest(text);
      if (first !== second || first.length !== 8) return false;
    }
    return spec.category === 'hash';
  }
}
