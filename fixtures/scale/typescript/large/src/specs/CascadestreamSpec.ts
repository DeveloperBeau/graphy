// Test parameters for the cascadestream family.
export interface CascadestreamSpecShape {
  name: string;
  category: string;
  key: number;
}

export class CascadestreamSpec {
  static get(): CascadestreamSpecShape {
    return { name: 'cascadestream', category: 'stream', key: 11 };
  }

  static notes(): string {
    return 'lcg archetype, fixture key 11';
  }
}
