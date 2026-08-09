-- The three fleet machines: server, desktop and low-power board.
CREATE TABLE machines (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    kind TEXT NOT NULL,
    cores SMALLINT NOT NULL,
    has_aes_ni BOOLEAN NOT NULL DEFAULT FALSE,
    added_on DATE NOT NULL
);

CREATE INDEX machines_kind_idx ON machines (kind);

CREATE INDEX machines_name_idx ON machines (name);

CREATE INDEX machines_kind_idx ON machines (kind);
