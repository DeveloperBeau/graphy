// Sample inputs for mask family checks.
export class CorpusMask {
  static texts(): string[] {
    return [
      'blue lantern lit',
      'signal from the tower',
      'keys in the garden',
    ];
  }

  static size(): number {
    return CorpusMask.texts().length;
  }
}
