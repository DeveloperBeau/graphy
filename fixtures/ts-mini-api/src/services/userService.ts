import type { User } from "../models/user";

export class UserService {
  all(): User[] {
    return [{ id: 1, name: "ada" }, { id: 2, name: "linus" }];
  }
}
