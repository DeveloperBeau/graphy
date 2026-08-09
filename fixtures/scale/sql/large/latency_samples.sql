-- Key setup and first-byte latency per pass.
CREATE TABLE latency_samples (
    id BIGSERIAL PRIMARY KEY,
    pass_id BIGINT NOT NULL REFERENCES passes (id),
    setup_nanos BIGINT NOT NULL,
    first_byte_nanos BIGINT NOT NULL
);

CREATE INDEX latency_samples_pass_id_idx ON latency_samples (pass_id);

CREATE INDEX latency_samples_setup_nanos_idx ON latency_samples (setup_nanos);

CREATE INDEX latency_samples_first_byte_nanos_idx ON latency_samples (first_byte_nanos);
