# graphy vs graphy — comparison report

_generated: 2026-05-24T13:00:14Z; trials per cell: 3_

## Wall time (best of 3)

| fixture | graphy (ms) | graphy (ms) | speedup |
|---|---:|---:|---:|
| go-mini-service | 23 | 131 | 5.7× |
| medium-multilang | 26 | 315 | 12.1× |
| python-mini-cli | 23 | 136 | 5.9× |
| rust-mini-webserver | 23 | 130 | 5.7× |
| ts-mini-api | 23 | 129 | 5.6× |

## Peak RSS (worst of 3)

| fixture | graphy | graphy |
|---|---:|---:|
| go-mini-service | 5.3 MB | 43.1 MB |
| medium-multilang | 8.7 MB | 47.0 MB |
| python-mini-cli | 5.4 MB | 43.3 MB |
| rust-mini-webserver | 5.6 MB | 43.6 MB |
| ts-mini-api | 5.9 MB | 43.8 MB |

## Graph shape

| fixture | graphy nodes | graphy nodes | graphy edges | graphy edges |
|---|---:|---:|---:|---:|
| go-mini-service | 12 | 9 | 4 | 0 |
| medium-multilang | 217 | 186 | 120 | 0 |
| python-mini-cli | 11 | 11 | 4 | 0 |
| rust-mini-webserver | 16 | 12 | 3 | 0 |
| ts-mini-api | 14 | 14 | 4 | 0 |

## Relation distribution

**go-mini-service**

  - graphy: imports=4
  - graphy: 

**medium-multilang**

  - graphy: calls=44,imports=76
  - graphy: 

**python-mini-cli**

  - graphy: imports=4
  - graphy: 

**rust-mini-webserver**

  - graphy: imports=3
  - graphy: 

**ts-mini-api**

  - graphy: imports=4
  - graphy: 

> _Note:_ `graphy` is the no-LLM extract+graph path. In v8
> it re-extracts nodes but does not always emit edges on the first
> call (the edge / call-graph pass runs in a separate stage).
