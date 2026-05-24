# Fixtures

Sample projects used to validate graphy against graphy. Each fixture is **synthesized** — similar in shape and patterns to projects that graphy is exercised against in the wild, but **not** a copy of any upstream fixture.

| Fixture                       | Language     | Files | Purpose                                                  |
|-------------------------------|--------------|-------|----------------------------------------------------------|
| `rust-mini-webserver/`        | Rust         | ~6    | router + handlers + middleware; deep call chains.        |
| `python-mini-cli/`            | Python       | ~5    | CLI app with command modules + a shared util layer.      |
| `ts-mini-api/`                | TS/JS        | ~5    | TS service with controllers + services + models.         |
| `go-mini-service/`            | Go           | ~5    | HTTP service with package-scoped functions.              |

The harness at `../bench/compare.sh` runs both engines on each fixture and prints a side-by-side comparison.
