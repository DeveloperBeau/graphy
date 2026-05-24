import { Store } from "../services/store";
import type { Entity } from "../models/entity";

export class Controller4 {
  private store = new Store();

  handle(): void {
    const e: Entity = { id: 4, kind: "c4" };
    this.store.put(e);
    const n = this.store.all().length;
    console.log("c4:", n);
  }
}
