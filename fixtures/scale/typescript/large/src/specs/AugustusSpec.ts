// Test parameters for the augustus family.
export interface AugustusSpecShape {
  name: string;
  category: string;
  key: number;
}

export class AugustusSpec {
  static get(): AugustusSpecShape {
    return { name: 'augustus', category: 'additive', key: 8 };
  }

  static notes(): string {
    return 'shift archetype, fixture key 8';
  }
}
