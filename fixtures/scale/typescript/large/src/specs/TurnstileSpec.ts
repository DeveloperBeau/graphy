// Test parameters for the turnstile family.
export interface TurnstileSpecShape {
  name: string;
  category: string;
  key: number;
}

export class TurnstileSpec {
  static get(): TurnstileSpecShape {
    return { name: 'turnstile', category: 'rotate', key: 3 };
  }

  static notes(): string {
    return 'rotate archetype, fixture key 3';
  }
}
