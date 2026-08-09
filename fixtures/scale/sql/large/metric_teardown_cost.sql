-- Secondary metric samples: teardown cost.
CREATE TABLE metric_teardown_cost (
    id BIGSERIAL PRIMARY KEY,
    pass_id BIGINT NOT NULL REFERENCES passes (id),
    value BIGINT NOT NULL,
    unit TEXT NOT NULL DEFAULT 'count'
);

CREATE INDEX metric_teardown_cost_pass_idx ON metric_teardown_cost (pass_id);

CREATE INDEX metric_teardown_cost_pass_id_idx ON metric_teardown_cost (pass_id);

CREATE INDEX metric_teardown_cost_value_idx ON metric_teardown_cost (value);
