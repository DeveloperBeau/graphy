// Test parameters for the staticpad family.
export interface StaticpadSpecShape {
  name: string;
  category: string;
  key: number;
}

export class StaticpadSpec {
  static get(): StaticpadSpecShape {
    return { name: 'staticpad', category: 'mask', key: 7 };
  }

  static notes(): string {
    return 'xor archetype, fixture key 7';
  }
}
