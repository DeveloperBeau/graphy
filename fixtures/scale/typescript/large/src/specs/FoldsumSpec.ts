// Test parameters for the foldsum family.
export interface FoldsumSpecShape {
  name: string;
  category: string;
  key: number;
}

export class FoldsumSpec {
  static get(): FoldsumSpecShape {
    return { name: 'foldsum', category: 'hash', key: 12 };
  }

  static notes(): string {
    return 'hash archetype, fixture key 12';
  }
}
