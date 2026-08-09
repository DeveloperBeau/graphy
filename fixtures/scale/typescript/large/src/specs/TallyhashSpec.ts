// Test parameters for the tallyhash family.
export interface TallyhashSpecShape {
  name: string;
  category: string;
  key: number;
}

export class TallyhashSpec {
  static get(): TallyhashSpecShape {
    return { name: 'tallyhash', category: 'hash', key: 14 };
  }

  static notes(): string {
    return 'hash archetype, fixture key 14';
  }
}
