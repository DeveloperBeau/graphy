// Test parameters for the stridecode family.
export interface StridecodeSpecShape {
  name: string;
  category: string;
  key: number;
}

export class StridecodeSpec {
  static get(): StridecodeSpecShape {
    return { name: 'stridecode', category: 'codec', key: 9 };
  }

  static notes(): string {
    return 'codec archetype, fixture key 9';
  }
}
