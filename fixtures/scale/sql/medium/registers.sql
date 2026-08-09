-- The ten persistent memory registers per user.
CREATE TABLE registers (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users (id),
    slot SMALLINT NOT NULL,
    value NUMERIC NOT NULL DEFAULT 0,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX registers_user_slot_idx ON registers (user_id, slot);

CREATE INDEX registers_user_id_idx ON registers (user_id);

CREATE INDEX registers_slot_idx ON registers (slot);
