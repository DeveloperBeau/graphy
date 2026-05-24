import type { Entity } from "../models/entity";

export class Store {
  private items: Entity[] = [];
  put(e: Entity): void { this.items.push(e); }
  all(): Entity[] { return this.items; }
}
