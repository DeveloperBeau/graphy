import { Store } from "../services/store";
import type { Entity } from "../models/entity";

export class Controller3 {
  private store = new Store();

  handle(): void {
    const e: Entity = { id: 3, kind: "c3" };
    this.store.put(e);
    const n = this.store.all().length;
    console.log("c3:", n);
  }
}
