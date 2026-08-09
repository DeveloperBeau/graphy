// Test parameters for the shiftreel family.
export interface ShiftreelSpecShape {
  name: string;
  category: string;
  key: number;
}

export class ShiftreelSpec {
  static get(): ShiftreelSpecShape {
    return { name: 'shiftreel', category: 'additive', key: 6 };
  }

  static notes(): string {
    return 'shift archetype, fixture key 6';
  }
}
