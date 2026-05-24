import { Controller0 } from "./controllers/c0";
import { Controller3 } from "./controllers/c3";
import { Controller7 } from "./controllers/c7";

export class App {
  start(): void {
    new Controller0().handle();
    new Controller3().handle();
    new Controller7().handle();
  }
}
