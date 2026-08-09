// Test parameters for the carousel family.
export interface CarouselSpecShape {
  name: string;
  category: string;
  key: number;
}

export class CarouselSpec {
  static get(): CarouselSpecShape {
    return { name: 'carousel', category: 'rotate', key: 18 };
  }

  static notes(): string {
    return 'rotate archetype, fixture key 18';
  }
}
