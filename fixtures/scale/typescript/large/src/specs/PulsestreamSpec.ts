// Test parameters for the pulsestream family.
export interface PulsestreamSpecShape {
  name: string;
  category: string;
  key: number;
}

export class PulsestreamSpec {
  static get(): PulsestreamSpecShape {
    return { name: 'pulsestream', category: 'stream', key: 10 };
  }

  static notes(): string {
    return 'lcg archetype, fixture key 10';
  }
}
