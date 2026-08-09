// Test parameters for the stairstep family.
export interface StairstepSpecShape {
  name: string;
  category: string;
  key: number;
}

export class StairstepSpec {
  static get(): StairstepSpecShape {
    return { name: 'stairstep', category: 'additive', key: 7 };
  }

  static notes(): string {
    return 'shift archetype, fixture key 7';
  }
}
