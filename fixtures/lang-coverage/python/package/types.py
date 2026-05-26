# feature: class, constants, inheritance target (Greet base class)

MAX_RETRIES = 3
SERVICE_NAME = "graphy-python-fixture"


class State:
    IDLE = "idle"
    RUNNING = "running"
    DONE = "done"


class Greet:
    def hi(self) -> str:
        return "hello"
