// Test parameters for the gronsfeld family.
export interface GronsfeldSpecShape {
  name: string;
  category: string;
  key: number;
}

export class GronsfeldSpec {
  static get(): GronsfeldSpecShape {
    return { name: 'gronsfeld', category: 'additive', key: 4 };
  }

  static notes(): string {
    return 'shift archetype, fixture key 4';
  }
}
