// Test parameters for the sparkstream family.
export interface SparkstreamSpecShape {
  name: string;
  category: string;
  key: number;
}

export class SparkstreamSpec {
  static get(): SparkstreamSpecShape {
    return { name: 'sparkstream', category: 'stream', key: 15 };
  }

  static notes(): string {
    return 'lcg archetype, fixture key 15';
  }
}
