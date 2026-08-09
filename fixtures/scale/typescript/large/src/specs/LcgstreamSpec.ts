// Test parameters for the lcgstream family.
export interface LcgstreamSpecShape {
  name: string;
  category: string;
  key: number;
}

export class LcgstreamSpec {
  static get(): LcgstreamSpecShape {
    return { name: 'lcgstream', category: 'stream', key: 8 };
  }

  static notes(): string {
    return 'lcg archetype, fixture key 8';
  }
}
