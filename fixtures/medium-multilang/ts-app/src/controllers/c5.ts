import { Store } from "../services/store";
import type { Entity } from "../models/entity";

export class Controller5 {
  private store = new Store();

  handle(): void {
    const e: Entity = { id: 5, kind: "c5" };
    this.store.put(e);
    const n = this.store.all().length;
    console.log("c5:", n);
  }
}
