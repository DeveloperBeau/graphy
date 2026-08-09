// Test parameters for the fnvhash family.
export interface FnvhashSpecShape {
  name: string;
  category: string;
  key: number;
}

export class FnvhashSpec {
  static get(): FnvhashSpecShape {
    return { name: 'fnvhash', category: 'hash', key: 7 };
  }

  static notes(): string {
    return 'hash archetype, fixture key 7';
  }
}
