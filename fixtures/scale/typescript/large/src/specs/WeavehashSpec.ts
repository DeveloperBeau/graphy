// Test parameters for the weavehash family.
export interface WeavehashSpecShape {
  name: string;
  category: string;
  key: number;
}

export class WeavehashSpec {
  static get(): WeavehashSpecShape {
    return { name: 'weavehash', category: 'hash', key: 16 };
  }

  static notes(): string {
    return 'hash archetype, fixture key 16';
  }
}
