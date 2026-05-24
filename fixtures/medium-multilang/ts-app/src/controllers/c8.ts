import { Store } from "../services/store";
import type { Entity } from "../models/entity";

export class Controller8 {
  private store = new Store();

  handle(): void {
    const e: Entity = { id: 8, kind: "c8" };
    this.store.put(e);
    const n = this.store.all().length;
    console.log("c8:", n);
  }
}
