-- Named inkroll pipelines watched by the daemon.
CREATE TABLE queues (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    preset_name TEXT NOT NULL DEFAULT 'plain',
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX queues_preset_idx ON queues (preset_name);

CREATE INDEX queues_name_idx ON queues (name);

CREATE INDEX queues_preset_name_idx ON queues (preset_name);
