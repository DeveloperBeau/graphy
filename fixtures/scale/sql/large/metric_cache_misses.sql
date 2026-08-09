-- Secondary metric samples: cache misses.
CREATE TABLE metric_cache_misses (
    id BIGSERIAL PRIMARY KEY,
    pass_id BIGINT NOT NULL REFERENCES passes (id),
    value BIGINT NOT NULL,
    unit TEXT NOT NULL DEFAULT 'count'
);

CREATE INDEX metric_cache_misses_pass_idx ON metric_cache_misses (pass_id);

CREATE INDEX metric_cache_misses_pass_id_idx ON metric_cache_misses (pass_id);

CREATE INDEX metric_cache_misses_value_idx ON metric_cache_misses (value);
