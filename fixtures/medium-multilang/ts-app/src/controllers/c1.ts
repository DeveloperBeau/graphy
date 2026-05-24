import { Store } from "../services/store";
import type { Entity } from "../models/entity";

export class Controller1 {
  private store = new Store();

  handle(): void {
    const e: Entity = { id: 1, kind: "c1" };
    this.store.put(e);
    const n = this.store.all().length;
    console.log("c1:", n);
  }
}
