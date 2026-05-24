import { Store } from "../services/store";
import type { Entity } from "../models/entity";

export class Controller6 {
  private store = new Store();

  handle(): void {
    const e: Entity = { id: 6, kind: "c6" };
    this.store.put(e);
    const n = this.store.all().length;
    console.log("c6:", n);
  }
}
