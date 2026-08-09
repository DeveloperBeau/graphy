-- Secondary metric samples: page faults.
CREATE TABLE metric_page_faults (
    id BIGSERIAL PRIMARY KEY,
    pass_id BIGINT NOT NULL REFERENCES passes (id),
    value BIGINT NOT NULL,
    unit TEXT NOT NULL DEFAULT 'count'
);

CREATE INDEX metric_page_faults_pass_idx ON metric_page_faults (pass_id);

CREATE INDEX metric_page_faults_pass_id_idx ON metric_page_faults (pass_id);

CREATE INDEX metric_page_faults_value_idx ON metric_page_faults (value);
