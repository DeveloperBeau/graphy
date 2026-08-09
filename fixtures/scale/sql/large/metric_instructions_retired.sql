-- Secondary metric samples: instructions retired.
CREATE TABLE metric_instructions_retired (
    id BIGSERIAL PRIMARY KEY,
    pass_id BIGINT NOT NULL REFERENCES passes (id),
    value BIGINT NOT NULL,
    unit TEXT NOT NULL DEFAULT 'count'
);

CREATE INDEX metric_instructions_retired_pass_idx ON metric_instructions_retired (pass_id);

CREATE INDEX metric_instructions_retired_pass_id_idx ON metric_instructions_retired (pass_id);

CREATE INDEX metric_instructions_retired_value_idx ON metric_instructions_retired (value);
