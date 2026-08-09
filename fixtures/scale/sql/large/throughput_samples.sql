-- Steady-state throughput reading per pass.
CREATE TABLE throughput_samples (
    id BIGSERIAL PRIMARY KEY,
    pass_id BIGINT NOT NULL REFERENCES passes (id),
    bytes_per_second BIGINT NOT NULL
);

CREATE INDEX throughput_samples_pass_id_idx ON throughput_samples (pass_id);

CREATE INDEX throughput_samples_bytes_per_second_idx ON throughput_samples (bytes_per_second);
