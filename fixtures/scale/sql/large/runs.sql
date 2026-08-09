-- One row per nightly (or ad hoc) benchmark run.
CREATE TABLE runs (
    id BIGSERIAL PRIMARY KEY,
    machine_id BIGINT NOT NULL REFERENCES machines (id),
    started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    finished_at TIMESTAMPTZ,
    tag TEXT NOT NULL DEFAULT 'nightly'
);

CREATE INDEX runs_machine_idx ON runs (machine_id);

CREATE INDEX runs_machine_id_idx ON runs (machine_id);

CREATE INDEX runs_started_at_idx ON runs (started_at);
