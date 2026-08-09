// Test parameters for the orbitstream family.
export interface OrbitstreamSpecShape {
  name: string;
  category: string;
  key: number;
}

export class OrbitstreamSpec {
  static get(): OrbitstreamSpecShape {
    return { name: 'orbitstream', category: 'stream', key: 12 };
  }

  static notes(): string {
    return 'lcg archetype, fixture key 12';
  }
}
