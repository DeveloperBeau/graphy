-- Secondary metric samples: branch mispredicts.
CREATE TABLE metric_branch_mispredicts (
    id BIGSERIAL PRIMARY KEY,
    pass_id BIGINT NOT NULL REFERENCES passes (id),
    value BIGINT NOT NULL,
    unit TEXT NOT NULL DEFAULT 'count'
);

CREATE INDEX metric_branch_mispredicts_pass_idx ON metric_branch_mispredicts (pass_id);

CREATE INDEX metric_branch_mispredicts_pass_id_idx ON metric_branch_mispredicts (pass_id);

CREATE INDEX metric_branch_mispredicts_value_idx ON metric_branch_mispredicts (value);
