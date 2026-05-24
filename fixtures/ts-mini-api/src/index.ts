import { UserController } from "./controllers/users";
import { HealthController } from "./controllers/health";

const users = new UserController();
const health = new HealthController();

users.list();
health.check();
