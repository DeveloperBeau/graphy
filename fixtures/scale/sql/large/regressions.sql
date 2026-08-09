-- Flagged regressions between consecutive nightly runs.
CREATE TABLE regressions (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    detected_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    metric TEXT NOT NULL,
    delta_percent NUMERIC NOT NULL
);

CREATE INDEX regressions_cipher_idx ON regressions (cipher_family_id);

CREATE INDEX regressions_cipher_family_id_idx ON regressions (cipher_family_id);

CREATE INDEX regressions_detected_at_idx ON regressions (detected_at);
