// Test parameters for the driftstream family.
export interface DriftstreamSpecShape {
  name: string;
  category: string;
  key: number;
}

export class DriftstreamSpec {
  static get(): DriftstreamSpecShape {
    return { name: 'driftstream', category: 'stream', key: 9 };
  }

  static notes(): string {
    return 'lcg archetype, fixture key 9';
  }
}
