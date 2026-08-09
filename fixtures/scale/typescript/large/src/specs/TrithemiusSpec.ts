// Test parameters for the trithemius family.
export interface TrithemiusSpecShape {
  name: string;
  category: string;
  key: number;
}

export class TrithemiusSpec {
  static get(): TrithemiusSpecShape {
    return { name: 'trithemius', category: 'additive', key: 5 };
  }

  static notes(): string {
    return 'shift archetype, fixture key 5';
  }
}
