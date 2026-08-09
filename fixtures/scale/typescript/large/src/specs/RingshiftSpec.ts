// Test parameters for the ringshift family.
export interface RingshiftSpecShape {
  name: string;
  category: string;
  key: number;
}

export class RingshiftSpec {
  static get(): RingshiftSpecShape {
    return { name: 'ringshift', category: 'rotate', key: 17 };
  }

  static notes(): string {
    return 'rotate archetype, fixture key 17';
  }
}
