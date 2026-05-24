import { Store } from "../services/store";
import type { Entity } from "../models/entity";

export class Controller2 {
  private store = new Store();

  handle(): void {
    const e: Entity = { id: 2, kind: "c2" };
    this.store.put(e);
    const n = this.store.all().length;
    console.log("c2:", n);
  }
}
