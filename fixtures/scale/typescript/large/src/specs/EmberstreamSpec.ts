// Test parameters for the emberstream family.
export interface EmberstreamSpecShape {
  name: string;
  category: string;
  key: number;
}

export class EmberstreamSpec {
  static get(): EmberstreamSpecShape {
    return { name: 'emberstream', category: 'stream', key: 13 };
  }

  static notes(): string {
    return 'lcg archetype, fixture key 13';
  }
}
