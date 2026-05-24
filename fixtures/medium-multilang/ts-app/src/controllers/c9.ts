import { Store } from "../services/store";
import type { Entity } from "../models/entity";

export class Controller9 {
  private store = new Store();

  handle(): void {
    const e: Entity = { id: 9, kind: "c9" };
    this.store.put(e);
    const n = this.store.all().length;
    console.log("c9:", n);
  }
}
