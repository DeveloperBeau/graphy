// Test parameters for the modwheel family.
export interface ModwheelSpecShape {
  name: string;
  category: string;
  key: number;
}

export class ModwheelSpec {
  static get(): ModwheelSpecShape {
    return { name: 'modwheel', category: 'affine', key: 14 };
  }

  static notes(): string {
    return 'affine archetype, fixture key 14';
  }
}
