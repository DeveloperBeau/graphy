-- Per-queue overrides of the global config file keys.
CREATE TABLE config_overrides (
    id BIGSERIAL PRIMARY KEY,
    queue_id BIGINT NOT NULL REFERENCES queues (id),
    key TEXT NOT NULL,
    value TEXT NOT NULL
);

CREATE INDEX config_overrides_queue_id_idx ON config_overrides (queue_id);

CREATE INDEX config_overrides_key_idx ON config_overrides (key);

CREATE INDEX config_overrides_value_idx ON config_overrides (value);
