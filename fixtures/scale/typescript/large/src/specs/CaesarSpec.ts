// Test parameters for the caesar family.
export interface CaesarSpecShape {
  name: string;
  category: string;
  key: number;
}

export class CaesarSpec {
  static get(): CaesarSpecShape {
    return { name: 'caesar', category: 'additive', key: 3 };
  }

  static notes(): string {
    return 'shift archetype, fixture key 3';
  }
}
