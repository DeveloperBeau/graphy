-- Peak memory readings per pass.
CREATE TABLE memory_samples (
    id BIGSERIAL PRIMARY KEY,
    pass_id BIGINT NOT NULL REFERENCES passes (id),
    peak_working_set_bytes BIGINT NOT NULL,
    expanded_key_bytes INTEGER NOT NULL
);

CREATE INDEX memory_samples_pass_id_idx ON memory_samples (pass_id);

CREATE INDEX memory_samples_peak_working_set_bytes_idx ON memory_samples (peak_working_set_bytes);

CREATE INDEX memory_samples_expanded_key_bytes_idx ON memory_samples (expanded_key_bytes);
