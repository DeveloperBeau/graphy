// Test parameters for the djbhash family.
export interface DjbhashSpecShape {
  name: string;
  category: string;
  key: number;
}

export class DjbhashSpec {
  static get(): DjbhashSpecShape {
    return { name: 'djbhash', category: 'hash', key: 8 };
  }

  static notes(): string {
    return 'hash archetype, fixture key 8';
  }
}
