-- Named devices a user has synced settings to.
CREATE TABLE device_bindings (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users (id),
    label TEXT NOT NULL,
    last_seen_at TIMESTAMPTZ
);

CREATE INDEX device_bindings_user_id_idx ON device_bindings (user_id);

CREATE INDEX device_bindings_label_idx ON device_bindings (label);

CREATE INDEX device_bindings_last_seen_at_idx ON device_bindings (last_seen_at);
