// Sample inputs for affine family checks.
export class CorpusAffine {
  static texts(): string[] {
    return [
      'seven silver swans',
      'crossing the river',
      'map under the floor',
    ];
  }

  static size(): number {
    return CorpusAffine.texts().length;
  }
}
