// Test parameters for the weavecode family.
export interface WeavecodeSpecShape {
  name: string;
  category: string;
  key: number;
}

export class WeavecodeSpec {
  static get(): WeavecodeSpecShape {
    return { name: 'weavecode', category: 'codec', key: 8 };
  }

  static notes(): string {
    return 'codec archetype, fixture key 8';
  }
}
