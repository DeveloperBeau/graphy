import { UserService } from "../services/userService";

export class UserController {
  private svc = new UserService();

  list(): void {
    const all = this.svc.all();
    console.log(`users: ${all.length}`);
  }
}
