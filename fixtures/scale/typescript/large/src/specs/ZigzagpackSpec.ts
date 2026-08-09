// Test parameters for the zigzagpack family.
export interface ZigzagpackSpecShape {
  name: string;
  category: string;
  key: number;
}

export class ZigzagpackSpec {
  static get(): ZigzagpackSpecShape {
    return { name: 'zigzagpack', category: 'codec', key: 5 };
  }

  static notes(): string {
    return 'codec archetype, fixture key 5';
  }
}
