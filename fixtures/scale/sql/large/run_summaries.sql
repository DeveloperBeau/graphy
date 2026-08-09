-- Median figures per run per cipher, computed after all passes land.
CREATE TABLE run_summaries (
    id BIGSERIAL PRIMARY KEY,
    run_id BIGINT NOT NULL REFERENCES runs (id),
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    median_throughput BIGINT NOT NULL,
    median_latency_nanos BIGINT NOT NULL,
    stable BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE INDEX run_summaries_cipher_idx ON run_summaries (cipher_family_id);

CREATE INDEX run_summaries_run_id_idx ON run_summaries (run_id);

CREATE INDEX run_summaries_cipher_family_id_idx ON run_summaries (cipher_family_id);
