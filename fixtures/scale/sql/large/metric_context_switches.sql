-- Secondary metric samples: context switches.
CREATE TABLE metric_context_switches (
    id BIGSERIAL PRIMARY KEY,
    pass_id BIGINT NOT NULL REFERENCES passes (id),
    value BIGINT NOT NULL,
    unit TEXT NOT NULL DEFAULT 'count'
);

CREATE INDEX metric_context_switches_pass_idx ON metric_context_switches (pass_id);

CREATE INDEX metric_context_switches_pass_id_idx ON metric_context_switches (pass_id);

CREATE INDEX metric_context_switches_value_idx ON metric_context_switches (value);
