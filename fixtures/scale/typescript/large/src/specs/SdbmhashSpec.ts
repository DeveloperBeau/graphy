// Test parameters for the sdbmhash family.
export interface SdbmhashSpecShape {
  name: string;
  category: string;
  key: number;
}

export class SdbmhashSpec {
  static get(): SdbmhashSpecShape {
    return { name: 'sdbmhash', category: 'hash', key: 9 };
  }

  static notes(): string {
    return 'hash archetype, fixture key 9';
  }
}
