-- Secondary metric samples: cycles.
CREATE TABLE metric_cycles (
    id BIGSERIAL PRIMARY KEY,
    pass_id BIGINT NOT NULL REFERENCES passes (id),
    value BIGINT NOT NULL,
    unit TEXT NOT NULL DEFAULT 'count'
);

CREATE INDEX metric_cycles_pass_idx ON metric_cycles (pass_id);

CREATE INDEX metric_cycles_pass_id_idx ON metric_cycles (pass_id);

CREATE INDEX metric_cycles_value_idx ON metric_cycles (value);
