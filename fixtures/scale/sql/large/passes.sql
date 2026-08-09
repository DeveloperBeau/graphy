-- Individual measured passes within a run.
CREATE TABLE passes (
    id BIGSERIAL PRIMARY KEY,
    run_id BIGINT NOT NULL REFERENCES runs (id),
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    pass_no SMALLINT NOT NULL,
    rejected BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX passes_run_cipher_idx ON passes (run_id, cipher_family_id);

CREATE INDEX passes_run_id_idx ON passes (run_id);

CREATE INDEX passes_cipher_family_id_idx ON passes (cipher_family_id);
