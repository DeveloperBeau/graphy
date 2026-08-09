// Test parameters for the mixcrc family.
export interface MixcrcSpecShape {
  name: string;
  category: string;
  key: number;
}

export class MixcrcSpec {
  static get(): MixcrcSpecShape {
    return { name: 'mixcrc', category: 'hash', key: 13 };
  }

  static notes(): string {
    return 'hash archetype, fixture key 13';
  }
}
