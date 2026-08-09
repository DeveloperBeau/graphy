// Test parameters for the keypad family.
export interface KeypadSpecShape {
  name: string;
  category: string;
  key: number;
}

export class KeypadSpec {
  static get(): KeypadSpecShape {
    return { name: 'keypad', category: 'additive', key: 9 };
  }

  static notes(): string {
    return 'shift archetype, fixture key 9';
  }
}
